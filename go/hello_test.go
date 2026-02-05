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
	t.Run("Saying hello to people", func(t *testing.T) {
		got := Hello("Chris")
		want := "Hello, Chris"

		if got != want {
			t.Errorf("\nGot: %q \n Wanted: %q", got, want)
		}
	})

	t.Run("say 'Hello, World' when an empty string is supplied", func(t *testing.T) {
		got := Hello("")
		want := "Hello, World"

		if got != want {
			t.Errorf("\nGot: %q \n Wanted: %q", got, want)
		}
	})
}
