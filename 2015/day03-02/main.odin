package main

import "core:bufio"
import "core:fmt"
import "core:os"
import "core:slice"

main :: proc() {
	houses := 1
	pos_x_santa, pos_y_santa, pos_x_robo, pos_y_robo: int
	coords: [dynamic][2]int
	defer delete(coords)
	append(&coords, [2]int{pos_x_santa, pos_y_santa})

	scanner: bufio.Scanner
	bufio.scanner_init(&scanner, os.to_reader(os.stdin))
	defer bufio.scanner_destroy(&scanner)
	bufio.scanner_scan(&scanner)
	str := bufio.scanner_text(&scanner)
	if err := bufio.scanner_error(&scanner); err != nil {
		fmt.eprintln("read error:", err)
		os.exit(1)
	}

	turn: bool
	for c in str {
		// Santa is false and Robo-Santa is true
		pos := [2]int {
			turn ? pos_x_robo : pos_x_santa,
			turn ? pos_y_robo : pos_y_santa,
		}

		switch c {
		case '^':
			pos.y += 1
		case '>':
			pos.x += 1
		case 'v':
			pos.y -= 1
		case '<':
			pos.x -= 1
		case:
			fmt.eprintln("invalid character:", c)
		}

		// check if they already were at this location
		if !slice.contains(coords[:], pos) {
			houses += 1
			append(&coords, pos)
		}
		if turn do pos_x_robo, pos_y_robo = pos.x, pos.y
		else do pos_x_santa, pos_y_santa = pos.x, pos.y

		turn = !turn
	}

	fmt.println(houses)
}
