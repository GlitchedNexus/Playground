package main

import (
	"fmt"
	"strings"
)

func HelloWorld() string {
	return "Hello World!"
}

const englishHelloPrefix = "Hello, "
const frenchHelloPrefix = "Bonjour, "
const spanishHelloPrefix = "Hola, "
const hindiHelloPrefix = "Namaste, "

func Hello(language, name string) string {

	if name == "" {
		name = "World"
	}

	language = strings.ToLower(language)

	if language == "spanish" {
		return spanishHelloPrefix + name
	}

	if language == "french" {
		return frenchHelloPrefix + name
	}

	if language == "hindi" {
		return hindiHelloPrefix + name
	}

	return englishHelloPrefix + name
}

func main() {
	fmt.Println(HelloWorld())
}
