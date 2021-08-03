package main

import (
	"fmt"
	"log"
	"strings"
	"sync"

	"github.com/cdutwhu/gotil/net"
	"github.com/digisan/gotk/env"
	"github.com/digisan/gotk/io"
	lk "github.com/digisan/logkit"
)

var (
	fSf           = fmt.Sprintf
	fPln          = fmt.Println
	fEf           = fmt.Errorf
	sLastIndex    = strings.LastIndex
	sTrim         = strings.Trim
	sTrimLeft     = strings.TrimLeft
	sTrimRight    = strings.TrimRight
	sSplit        = strings.Split
	sSplitN       = strings.SplitN
	sHasPrefix    = strings.HasPrefix
	sHasSuffix    = strings.HasSuffix
	sContains     = strings.Contains
	sJoin         = strings.Join
	failOnErr     = lk.FailOnErr
	failOnErrWhen = lk.FailOnErrWhen
	warnOnErr     = lk.WarnOnErr
	info          = lk.Log
	l2c           = lk.Log2C
	l2f           = lk.Log2F
	scanLine      = io.FileLineScan
	scanStrLine   = io.StrLineScan
	urlParamStr   = net.URLParamStr
	localIP       = net.LocalIP
	chunk2map     = env.Chunk2Map
	envValued     = env.EnvValued
)

const (
	PORT            = 1423 // PORT : this server port
	loopInterval    = 200  // Millisecond
	timeoutStartOne = 15   // Second
	timeoutStartAll = 60   // Second
	timeoutCloseAll = 30   // Second
	monitorInterval = 300  // Second
)

var (
	loopLmtStartOne = timeoutStartOne * 1000 / loopInterval
	loopLmtStartAll = timeoutStartAll * 1000 / loopInterval
	loopLmtCloseAll = timeoutCloseAll * 1000 / loopInterval
	logpath         = "./services_log/"
	mtx4log         = &sync.Mutex{}
)

func init() {
	log.SetFlags(log.LstdFlags) // overwrite "info/warn/fail" print style
}
