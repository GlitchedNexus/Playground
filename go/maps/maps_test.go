package maps

import "testing"

func TestSearch(t *testing.T) {

	t.Run("key exists in dictionary", func(t *testing.T) {
		dictionary := Dictionary{"test": "this is just a test"}

		key := "test"
		got, _ := dictionary.Search(key)
		want := "this is just a test"

		assertStrings(t, got, want, key)
	})

	t.Run("key not in the dictionary", func(t *testing.T) {
		dictionary := Dictionary{"test": "this is just a test"}

		key := "abrcadabra"
		_, got := dictionary.Search(key)

		if got == nil {
			t.Fatal("Expected error got nil")
		}

		assertError(t, got, ErrorKeyNotFound)
	})
}

func TestAdd(t *testing.T) {
	t.Run("", func(t *testing.T) {
		dictionary := Dictionary{}
		dictionary.Add("Key One", "Value One")

		got, _ := dictionary.Search("Key One")
		want := "Value One"

		assertStrings(t, got, want, "Key One")
	})
}

func assertStrings(t testing.TB, got, want, key string) {
	t.Helper()
	if got != want {
		t.Errorf("\nGot: %q\nWant: %q\nGiven: %q", got, want, key)
	}
}

func assertError(t testing.TB, got, want error) {
	t.Helper()
	if got != want {
		t.Errorf("\nGot: %q\nWant: %q\n", got, want)
	}
}
