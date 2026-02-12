package maps

import "errors"

var ErrorKeyNotFound = errors.New("Key not found")

type Dictionary map[string]string

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
