package smi

import "math"

func Perimeter(rectangle Rectangle) float64 {
	return 2 * (rectangle.Width + rectangle.Height)
}

func Area(rectangle Rectangle) float64 {
	return rectangle.Width * rectangle.Height
}

// A struct is a named collection of fields
// where we can save data.
type Rectangle struct {
	Width  float64
	Height float64
}

type Circle struct {
	Radius float64
}

type Triangle struct {
	Base   float64
	Height float64
}

// A method is a function with a receiver.
// A method declaration binds an identifier, the
// method name, to a method, and associates the
// method with the receiver's base type.
//
// It is a convention in Go to have the receiver
// variable be the first letter of the type. The
// general form of a method is:
// func (receiverName ReceiverType) MethodName(args)
func (c Circle) Area() float64 {
	return math.Pi * c.Radius * c.Radius
}

func (r Rectangle) Area() float64 {
	return r.Width * r.Height
}

func (t Triangle) Area() float64 {
	return 0.5 * t.Base * t.Height
}

type Shape interface {
	Area() float64
}
