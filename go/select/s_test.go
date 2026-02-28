package s

import (
	"net/http"
	"net/http/httptest"
	"testing"
	"time"
)

func TestRacer(t *testing.T) {
	t.Run("compares speeds of servers, returning the url of the fastest one", func(t *testing.T) {
		fastServer := makeDelayedServer(time.Millisecond * 0)
		slowServer := makeDelayedServer(time.Millisecond * 20)

		defer fastServer.Close()
		defer slowServer.Close()

		fastURL := fastServer.URL
		slowURL := slowServer.URL

		got, err := Racer(fastURL, slowURL)
		want := fastURL

		if got != want {
			t.Errorf("\nGOT: %s\nWANT: %s\n", got, want)
		}

		if err != nil {
			t.Error("Expected no error got one.")
		}
	})

	t.Run("returns an error if a server doesn't respond within 10s", func(t *testing.T) {
		server := makeDelayedServer(25 * time.Millisecond)

		defer server.Close()

		_, err := ConfigurableRacer(server.URL, server.URL, 20*time.Millisecond)

		if err == nil {
			t.Error("Expected error got nil.")
		}
	})
}

func makeDelayedServer(delay time.Duration) *httptest.Server {
	return httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		time.Sleep(delay)
		w.WriteHeader(http.StatusOK)
	}))
}
