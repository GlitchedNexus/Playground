package maps

import "errors"

var ErrorKeyNotFound = errors.New("Key not found")

type Dictionary map[string]string

// An interesting property of maps is that you can
// modify them without passing as an address to
// it (e.g &myMap).
//
// This may make them feel like a "reference type",
// but they are not.
//
// A map value is a pointer to a runtime.hmap structure.
// So when you pass a map to a function/method,
// you are indeed copying it, but just the pointer part,
// not the underlying data structure that contains the data.
//
// The one problematic bevaiour ab out maps is that they can
// be nil values. They behave normally when you try to read from them
// but attempts to write to them will cause a runtime panic.
//
// Therefore, you should never initialize a nil map variable as below:
// var m map[string]string
//
// Instead, you can initialize an empty map or use the
// make keyword to create a map for you:
//
// var dictionary = map[string]string{}
// OR
// var dictionary = make(map[string]string)
//
// Both approaches create an empty hash map and point
// dictionary at it. Which ensures that you will
// never get a runtime panic.
//

func (d Dictionary) Search(key string) (string, error) {
	val, ok := d[key]
	if !ok {
		return "", ErrorKeyNotFound
	}

	return val, nil
}

func (d Dictionary) Add(key, value string) {
	d[key] = value
}
