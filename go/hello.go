package main

import "fmt"

func HelloWorld() string {
	return "Hello World!"
}

const englishHelloPrefix = "Hello, "

func Hello(name string) string {

	if name == "" {
		name = "World"
	}

	return englishHelloPrefix + name
	// return fmt.Sprintf("Hello, %s", name)
}

func main() {
	fmt.Println(HelloWorld())
}
