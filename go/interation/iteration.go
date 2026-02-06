package interation

import "strings"

func Repeat(count int, str string) string {
	var repeated strings.Builder

	// Since strings in Go are immutable,
	// concatanation is expensive since we need
	// to assign new memory for the resulting string.
	//
	// We switch to using the stringBuilder since it
	// minimizeds memory copying. The WriteString
	// method let's us do concatanation.
	for range count {
		repeated.WriteString(str)
	}

	return repeated.String()
}

func main() {
}
