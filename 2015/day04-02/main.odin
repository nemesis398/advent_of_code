package main

import "core:bufio"
import "core:crypto/hash"
import "core:encoding/hex"
import "core:fmt"
import "core:os"
import "core:strings"

main :: proc() {
	scanner: bufio.Scanner
	bufio.scanner_init(&scanner, os.to_reader(os.stdin))
	defer bufio.scanner_destroy(&scanner)
	bufio.scanner_scan(&scanner)
	str := bufio.scanner_text(&scanner)
	if err := bufio.scanner_error(&scanner); err != nil {
		fmt.eprintln("read error:", err)
		os.exit(1)
	}

	result := str
	i: int
	digest: []byte
	defer delete(digest)
	for ; !strings.starts_with(result, "000000"); i += 1 {
		test_str := fmt.aprintf("%s%d", str, i)
		fmt.printf("Testing: %s... ", test_str)
		digest = hash.hash(.Insecure_MD5, test_str)
		result = string(hex.encode(digest))
		fmt.printfln("checksum => %s", result)
	}

	fmt.printfln(
		"The checksum for %s is %s with the number %d.",
		str,
		result,
		i - 1,
	)
}
