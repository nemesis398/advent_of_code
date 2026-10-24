package main

import "core:fmt"
import "core:os"

main :: proc() {
	floor := 0
	fmt.printf(
		"Santa starts at floor %d.\nWhere should he move to now? ",
		floor,
	)

	buf: [10240]byte

	l, err := os.read(os.stdin, buf[:])
	if err != nil {
		fmt.eprintln("Error reading: ", err)
		return
	}

	for c in buf[:l - 1] {
		floor += c == '(' ? 1 : -1
	}

	fmt.printfln("Santa now is on floor %d.", floor)
}
