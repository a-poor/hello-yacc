//go:generate goyacc -o gopher.go -p sql gopher.y
package main

import (
	"fmt"
	"unicode"
)

type sqlLex struct {
	s   string
	pos int
}

func (l *sqlLex) Lex(lval *sqlSymType) int {
	var c rune = ' '
	for c == ' ' {
		if l.pos == len(l.s) {
			return 0
		}
		c = rune(l.s[l.pos])
		l.pos += 1
	}

	if unicode.IsDigit(c) {
		lval.val = int(c) - '0'
		return DIGIT
	} else if unicode.IsLower(c) {
		lval.val = int(c) - 'a'
		return LETTER
	}
	return int(c)
}

func (l *sqlLex) Error(s string) {
	fmt.Printf("syntax error: %s\n", s)
}

func main() {
	// statement := "select * from foo"
	statement := "1 + 2"
	fmt.Println(statement)

}
