package main

import (
	"fmt"
	"os"

	"github.com/GlitchedNexus/blogposts/blogposts"
)

func main() {
	posts, err := blogposts.NewPostsFromFS(os.DirFS("posts"))
	if err != nil {
		return
	}
	fmt.Printf("POSTS:\n %+v \n", posts)
}
