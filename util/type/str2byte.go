package main

import (
	"encoding/hex"
	"fmt"
)

func str2byte(str string) string {
	var bl = []byte(str)
	var hs = hex.EncodeToString(bl)
	if len(hs) >= 64 {
		return "0x" + hs[0:64]
	}
	for {
		if len(hs) >= 64 {
			break
		}
		hs = hs + "0000"

	}
	return "0x" + hs[0:64]
}

func singleTest() {
	fmt.Println(str2byte("this is me"))
}

func multipleTest() {
	//var strs = [...]string{"Reg01", "1", "this is me", "this is json string", "Rel01", "Plf01", "Mtr01", "Pxy01"}
	//var strs = [...]string{"Reg02", "1", "this is me", "this is json string", "Rel01", "Plf02", "Mtr01", "Pxy02"}

	var strs = [...]string{"Reg01", "1", "this is me", "asset00", "music piece", "ethereum", "Rel01", "Plf01", "Mtr01", "Pxy01"}
	//var strs = [...]string{"Reg02", "1", "this is me", "asset01", "artwork", "ethereum", "Rel01", "Plf02", "Mtr01", "Pxy02"}

	for _, str := range strs {
		fmt.Println(str2byte(str))
	}
}

func main() {
	//singleTest()
	multipleTest()
}
