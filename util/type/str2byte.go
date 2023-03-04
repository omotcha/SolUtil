package main

import (
	"encoding/hex"
	"fmt"
)

func str2byte(str string) string {
	var bl = []byte(str)
	var hs = hex.EncodeToString(bl)
	fmt.Println(len(hs))
	if len(hs) >= 64 {
		return "0x" + hs[0:64]
	}
	for {
		if len(hs) >= 64 {
			break
		}
		hs = hs + "0000"

	}
	return "0x" + hs
}

func test() {
	fmt.Println(str2byte("proposal a"))
}

func main() {
	test()
}
