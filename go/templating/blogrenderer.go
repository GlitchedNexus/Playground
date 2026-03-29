package blogrenderer

import "io"

type Post struct {
	Title       string
	Body        string
	Description string
	Tags        []string
}

func Render(w io.Writer, post Post) error {
	return nil
}
