package main

import "testing"

func TestHelloWorld(t *testing.T) {
	got := HelloWorld()
	want := "Hello World!"

	if got != want {
		t.Errorf("\nGot: %q \n Wanted: %q", got, want)
	}
}

func TestHello(t *testing.T) {
	got := Hello("Chris")
	want := "Hello, Chris"

	if got != want {
		t.Errorf("\nGot: %q \n Wanted: %q", got, want)
	}
}
