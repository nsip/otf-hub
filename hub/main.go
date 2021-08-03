package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/postfinance/single"
)

func asyncExitListener() {
	for {
		exitcmd := ""
		if _, err := fmt.Scanf("%s", &exitcmd); err == nil {
			switch exitcmd {
			case "quit", "exit":
				closed := make(chan struct{})
				go closeServers(true, closed)
				<-closed
				err := StopExe(os.Getpid())
				if err != nil {
					log.SetFlags(log.Lshortfile | log.LstdFlags)
					log.Println(err)
				}
			}
		}
	}
}

func main() {
	one, err := single.New("hub", single.WithLockPath("/tmp"))
	failOnErr("%v", err)
	failOnErr("%v", one.Lock())
	defer func() {
		failOnErr("%v", one.Unlock())
		fPln("Hub Exited")
	}()

	// "quit", "exit" to exit hub
	go asyncExitListener()

	launched := make(chan struct{})
	go LaunchServices("./services4.md", "./otf-run.sh", false, launched)
	<-launched

	fPln("<--------------- 'exit' or 'quit' to end hub --------------->")

	// Start Service
	done := make(chan string)
	sig := make(chan os.Signal, 1)
	signal.Notify(sig, os.Interrupt, syscall.SIGTERM)
	go HostHTTPAsync(sig, done)
	<-done
	// logGrp.Do(<-done)
}

func shutdownAsync(e *echo.Echo, sig <-chan os.Signal, done chan<- string) {
	<-sig // got ctrl+c

	// close http
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	failOnErr("%v", e.Shutdown(ctx))
	time.Sleep(20 * time.Millisecond)
	done <- "Shutdown Successfully"
}

// HostHTTPAsync : Host a HTTP Server for XML to JSON
func HostHTTPAsync(sig <-chan os.Signal, done chan<- string) {
	// defer logGrp.Do("HostHTTPAsync Exit")

	e := echo.New()
	defer e.Close()

	// waiting for shutdown
	go shutdownAsync(e, sig, done)

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	e.Use(middleware.BodyLimit("2G"))
	// CORS
	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowCredentials: true,
		AllowOrigins:     []string{"*"},
		AllowMethods:     []string{echo.GET, echo.HEAD, echo.PUT, echo.PATCH, echo.POST, echo.DELETE},
		AllowHeaders:     []string{echo.HeaderOrigin, echo.HeaderContentType, echo.HeaderAccept, echo.HeaderAuthorization},
	}))

	e.Logger.SetOutput(os.Stdout)
	e.Logger.Infof(" ------------------------ e.Logger.Infof ------------------------ ")

	defer e.Start(fSf(":%d", PORT))
	// logGrp.Do("Echo Service is Starting ...")

}
