package blogrenderer

import (
	"fmt"
	"io"
)

type Post struct {
	Title       string
	Body        string
	Description string
	Tags        []string
}

func Render(w io.Writer, post Post) error {
	_, err := fmt.Fprintf(w, "<h1>%s</h1>\n<p>%s</p>", post.Title, post.Description)

	if err != nil {
		return err
	}

	_, err = fmt.Fprintf(w, "\nTags: <ul>")

	if err != nil {
		return err
	}

	for _, tag := range post.Tags {
		_, err = fmt.Fprintf(w, "<li>%s</li>", tag)
		if err != nil {
			return err
		}
	}

	_, err = fmt.Fprintf(w, "</ul>")

	if err != nil {
		return err
	}

	return nil
}
