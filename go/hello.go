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

	return GetPrefix(language) + name
}

func GetPrefix(language string) string {
	language = strings.ToLower(language)
	prefix := englishHelloPrefix

	switch language {
	case "spanish":
		prefix = spanishHelloPrefix
	case "french":
		prefix = frenchHelloPrefix
	case "hindi":
		prefix = hindiHelloPrefix
	}

	return prefix
}

func main() {
	fmt.Println(HelloWorld())
}
