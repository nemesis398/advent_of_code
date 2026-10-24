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

		x, _ := strconv.parse_int(split[0])
		y, _ := strconv.parse_int(split[1])
		z, _ := strconv.parse_int(split[2])

		two_smallest := x + y + z - max(x, y, z)

		total += 2 * two_smallest + x * y * z
	}
	if err := bufio.scanner_error(&scanner); err != nil {
		fmt.eprintln("read error:", err)
		os.exit(1)
	}

	fmt.println(total)
}
