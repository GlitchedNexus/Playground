package interation

import (
	"fmt"
	"testing"
)

func TestRepeat(t *testing.T) {
	repeated := Repeat(5, "a")
	expected := "aaaaa"

	if repeated != expected {
		t.Errorf("\n Expected: %q \n Got: %q", expected, repeated)
	}
}

// Help us find out how much running our code takes.
// By default, becnchmarks are run sequentially and only
// the body of the loop is timed. It automatically excludes
// the setup and cleanup code from benchmark timing.
func BenchmarkRepeat(b *testing.B) {
	for b.Loop() {
		Repeat(5, "a")
	}
}

func ExampleRepeat() {
	result := Repeat(5, "a")
	fmt.Println(result)
	// Output: aaaaa
}
