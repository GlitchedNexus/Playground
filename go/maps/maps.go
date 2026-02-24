package maps

const (
	ErrorKeyNotFound     = DictionaryErr("Key not found")
	ErrWordExists        = DictionaryErr("Key already exists")
	ErrorKeyDoesNotExist = DictionaryErr("Key you are trying to update doesn't exist.")
)

type Dictionary map[string]string

type DictionaryErr string

func (e DictionaryErr) Error() string {
	return string(e)
}

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

func (d Dictionary) Add(key, value string) error {
	_, err := d.Search(key)

	switch err {
	case ErrorKeyNotFound:
		d[key] = value
	case nil:
		return ErrWordExists
	default:
		return err
	}

	return nil
}

func (d Dictionary) Update(key, newValue string) error {
	_, err := d.Search(key)

	switch err {
	case ErrorKeyNotFound:
		return ErrorKeyDoesNotExist
	case nil:
		d[key] = newValue
	default:
		return err
	}

	return nil
}

func (d Dictionary) Delete(key string) (bool, error) {
	_, err := d.Search(key)

	switch err {
	case ErrorKeyNotFound:
		return false, ErrorKeyNotFound
	case nil:
		delete(d, key)
		return true, nil
	default:
		return false, err
	}
}
