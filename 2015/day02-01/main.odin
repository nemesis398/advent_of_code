package main

import "core:bufio"
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

main :: proc() {
	total: int

	scanner: bufio.Scanner
	bufio.scanner_init(&scanner, os.to_reader(os.stdin))
	defer bufio.scanner_destroy(&scanner)

	for bufio.scanner_scan(&scanner) {
		split := strings.split(bufio.scanner_text(&scanner), "x")
		length, _ := strconv.parse_int(split[0])
		width, _ := strconv.parse_int(split[1])
		heigth, _ := strconv.parse_int(split[2])

		surface_1 := width * length
		surface_2 := length * heigth
		surface_3 := heigth * width

		total +=
			2 * (surface_1 + surface_2 + surface_3) +
			min(surface_1, surface_2, surface_3)
	}
	if err := bufio.scanner_error(&scanner); err != nil {
		fmt.eprintln("read error:", err)
		os.exit(1)
	}

	fmt.println(total)
}
