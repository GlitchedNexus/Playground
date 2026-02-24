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
		err := dictionary.Add(key, value)

		assertError(t, err, nil)
		assertValue(t, dictionary, key, value)
	})

	t.Run("", func(t *testing.T) {
		key := "test"
		value := "this is just a test"
		dictionary := Dictionary{key: value}
		err := dictionary.Add(key, "new test")

		assertError(t, err, ErrWordExists)
		assertValue(t, dictionary, key, value)
	})
}

func TestUpdate(t *testing.T) {
	t.Run("test update where key is in the map", func(t *testing.T) {
		key := "Key One"
		value := "Value One"
		dictionary := Dictionary{key: value}
		newValue := "New Value"

		err := dictionary.Update(key, newValue)

		assertError(t, err, nil)
		assertValue(t, dictionary, key, newValue)
	})

	t.Run("test update where key is not in the map", func(t *testing.T) {
		key := "test"
		value := "this is just a test"
		dictionary := Dictionary{}

		err := dictionary.Update(key, value)

		assertError(t, err, ErrorKeyDoesNotExist)
	})
}

func TestDelete(t *testing.T) {
	t.Run("Delete key in the map", func(t *testing.T) {
		key := "Key One"
		value := "Value One"
		dictionary := Dictionary{key: value}

		success, err := dictionary.Delete(key)

		assertEquals(t, success, true)
		assertError(t, err, nil)

		_, err = dictionary.Search(key)
		assertError(t, err, ErrorKeyNotFound)
	})

	t.Run("Delete key not in the map", func(t *testing.T) {
		key := "Key One"
		dictionary := Dictionary{}

		success, err := dictionary.Delete(key)

		assertEquals(t, success, false)
		assertError(t, err, ErrorKeyNotFound)

	})
}

// ========================================================================
// +							Helpers									  +
// ========================================================================

func assertStrings(t testing.TB, got, want, key string) {
	t.Helper()
	if got != want {
		t.Errorf("\nGot: %q\nWant: %q\nGiven: %q", got, want, key)
	}
}

func assertEquals(t testing.TB, got, want any) {
	t.Helper()
	if got != want {
		t.Errorf("\nGot: %q\nWant: %q\n", got, want)
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
