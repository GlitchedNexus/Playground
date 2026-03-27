package blogposts_test

// By appending `_test` to our intended package name,
// we only access exported members from our package -
// just like a real user of our package.

import (
	"errors"
	"io/fs"
	"reflect"
	"testing"
	"testing/fstest"

	"github.com/GlitchedNexus/blogposts"
)

type StubFailingFS struct {
}

func (s StubFailingFS) Open(name string) (fs.File, error) {
	return nil, errors.New("oh no, i always fail")
}

func TestNewBlogPosts(t *testing.T) {
	t.Run("", func(t *testing.T) {
		fs := fstest.MapFS{
			"hello world.md":  {Data: []byte("Title: Post 1")},
			"hello-world2.md": {Data: []byte("Title: Post 2")},
		}

		posts, err := blogposts.NewPostsFromFS(fs)

		if err != nil {
			t.Fatal(err)
		}

		if len(posts) != len(fs) {
			t.Errorf("\nGOT:    %d posts\nWANTED: %d posts\n", len(posts), len(fs))
		}

		got := posts[0]
		want := blogposts.Post{Title: "Post 1"}

		if !reflect.DeepEqual(got, want) {
			t.Errorf("\nGOT:    %+v posts\nWANTED: %+v posts\n", got, want)
		}
	})

	t.Run("", func(t *testing.T) {
		_, err := blogposts.NewPostsFromFS(StubFailingFS{})

		if err == nil {
			t.Error("Exprected error got nil.")
		}
	})
}
