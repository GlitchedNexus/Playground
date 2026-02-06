package hello

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

// Naming the return value makes it available
// as a local variable and also let's text editors
// show the name fo return value with the
// function signature.
func GetPrefix(language string) (prefix string) {
	language = strings.ToLower(language)

	switch language {
	case "spanish":
		prefix = spanishHelloPrefix
	case "french":
		prefix = frenchHelloPrefix
	case "hindi":
		prefix = hindiHelloPrefix
	default:
		prefix = englishHelloPrefix
	}

	return
}

func main() {
	fmt.Println(HelloWorld())
}
