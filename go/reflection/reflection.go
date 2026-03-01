package reflection

import "reflect"

// Reflection in computing is the ability of a program to
// examine its own structure, particularly through types;
// it's a form of metaprogramming. It's also a great source
// of confusion.

func walk(x interface{}, fn func(string)) {
	val := reflect.ValueOf(x)
	field := val.Field(0)
	fn(field.String())
}
