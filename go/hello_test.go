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

		assertCorrectMessage(t, got, want)
	})

	t.Run("say 'Hello, World' when an empty string is supplied", func(t *testing.T) {
		got := Hello("")
		want := "Hello, World!"

		assertCorrectMessage(t, got, want)
	})
}

func assertCorrectMessage(t testing.TB, got, want string) {
	// Adding this line tells the compiler, hey i am just
	// a helper and when the test fails please only
	// report the line inside the actual test that cause the failure
	// and not the line in me that cause it.
	//
	// So, in the case of TestHello it will report the assertCorrectMessage
	// failed instead of oh t.Errorf was called.
	t.Helper()

	if got != want {
		t.Errorf("\nGot: %q \n Wanted: %q", got, want)
	}
}
