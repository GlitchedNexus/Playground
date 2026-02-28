package s

import "testing"

func TestRacer(t *testing.T) {
	fastURL := "http://www.facebook.com"
	slowURL := "http://www.quii.dev"

	got := Racer(fastURL, slowURL)
	want := fastURL

	if got != want {
		t.Errorf("\nGOT: %s\nWANT: %s\n", got, want)
	}
}
