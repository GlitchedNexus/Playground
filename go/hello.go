package main

import "fmt"

func HelloWorld() string {
	return "Hello World!"
}

func Hello(name string) string {
	return "Hello, " + name
	// return fmt.Sprintf("Hello, %s", name)
}

func main() {
	fmt.Println(HelloWorld())
}
