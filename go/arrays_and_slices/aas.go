package arraysandslices

func Sum(nums []int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}

	return sum
}

// This is a variadic function that can
// take a variable number of arguments.
func SumAll(numbersToSum ...[]int) []int {

	// Make let us make a slice with a starting
	// capacity of the length of the numbersToSum
	// we need to work through.
	//
	// The length of a slice is the number of elements
	// it holds measure by len(mySlice).
	//
	// The capacity onf the other hand is the
	// number of elements the slice can hold in the underlying
	// array by cap(mySlice).
	// You can index slices just like you would with arrays
	//
	// Implementation One:
	// length := len(numbersToSum)
	// sums := make([]int, length)

	// for i, numbers := range numbersToSum {
	// 	sums[i] = Sum(numbers)
	// }

	var sums []int

	for _, numbers := range numbersToSum {
		sums = append(sums, Sum(numbers))
	}

	return sums
}

func SumAllTails(numbersToSum ...[]int) []int {
	var sums []int

	for _, numbers := range numbersToSum {

		if len(numbers) == 0 {
			sums = append(sums, 0)

		} else {
			tail := numbers[1:]
			sums = append(sums, Sum(tail))
		}
	}

	return sums
}
