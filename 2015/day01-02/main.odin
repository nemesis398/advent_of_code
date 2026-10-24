package main

import "core:fmt"
import "core:os"

main :: proc() {
	floor, turn: int

	buf: [10240]byte

	l, err := os.read(os.stdin, buf[:])
	if err != nil {
		fmt.eprintln("Error reading: ", err)
		return
	}

	for c in buf[:l - 1] {
		floor += c == '(' ? 1 : -1
		turn += 1
		if floor < 0 do break
	}

	fmt.println(turn)
}
