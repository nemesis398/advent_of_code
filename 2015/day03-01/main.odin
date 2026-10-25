package main

import "core:bufio"
import "core:fmt"
import "core:os"
import "core:slice"

main :: proc() {
	houses := 1
	pos_x, pos_y: int
	coords: [dynamic][2]int
	defer delete(coords)
	append(&coords, [2]int{pos_x, pos_y})

	scanner: bufio.Scanner
	bufio.scanner_init(&scanner, os.to_reader(os.stdin))
	defer bufio.scanner_destroy(&scanner)

	bufio.scanner_scan(&scanner)
	str := bufio.scanner_text(&scanner)
	if err := bufio.scanner_error(&scanner); err != nil {
		fmt.eprintln("read error:", err)
		os.exit(1)
	}

	for c in str {
		// set Santas new position
		switch c {
		case '^':
			pos_y += 1
		case '>':
			pos_x += 1
		case 'v':
			pos_y -= 1
		case '<':
			pos_x -= 1
		case:
			fmt.eprintln("invalid character:", c)
		}

		// check if he already was at this position
		pos := [2]int{pos_x, pos_y}
		if !slice.contains(coords[:], pos) {
			houses += 1
			append(&coords, pos)
		}
	}

	fmt.println(houses)
}
