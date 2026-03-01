package reflection

import "testing"

func TestWalk(t *testing.T) {
	expected := "Chris"
	var got []string

	x := struct {
		Name string
	}{expected}

	walk(x, func(input string) {
		got = append(got, input)
	})

	if len(got) != 1 {
		t.Errorf("Wrong number of function calls!\nGOT: %d\nWANT: %d\n", len(got), 1)
	}

	if got[0] != expected {
		t.Errorf("\nGOT: %s\nWANT: %s\n", got, expected)
	}
}
