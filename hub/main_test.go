package main

import (
	"fmt"
	"testing"
)

func TestMain(t *testing.T) {
	main()
}

func TestSplit(t *testing.T) {
	s := "abcd"
	for _, p := range sSplit(s, "e") {
		fmt.Println(p)
	}
	kv := []string{}
	s = sJoin(kv, "=")
	fmt.Println(s, len(s))
}
