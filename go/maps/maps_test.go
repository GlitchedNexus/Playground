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
		key := "Key One"
		value := "Value One"
		dictionary.Add(key, value)

		assertValue(t, dictionary, key, value)
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

func assertValue(t testing.TB, dictionary Dictionary, key, value string) {
	t.Helper()
	got, err := dictionary.Search(key)

	if err != nil {
		t.Fatal("should find added word:", err)
	}
	assertStrings(t, got, value, key)
}
