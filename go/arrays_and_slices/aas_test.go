package arraysandslices

import (
	"reflect"
	"slices"
	"testing"
)

func TestSum(t *testing.T) {
	t.Run("Summing all ints in a collection of len 5.", func(t *testing.T) {
		numbers := []int{1, 2, 3, 4, 5}

		got := Sum(numbers)
		want := 15

		assetCorrectResult(t, got, want, numbers)
	})

	t.Run("Summing ints in collection of any size.", func(t *testing.T) {
		numbers := []int{1, 2, 3}

		got := Sum(numbers)
		want := 6

		assetCorrectResult(t, got, want, numbers)
	})
}

func assetCorrectResult(t *testing.T, got, want int, numbers []int) {
	t.Helper()
	if got != want {
		t.Errorf("\n Got: %d \n Wanted: %d \n Given: %v", got, want, numbers)
	}
}

func TestSumAll(t *testing.T) {
	got := SumAll([]int{1, 2}, []int{3, 4, 5})
	want := []int{3, 12}

	// Go does not let you use equality operators with slices.
	//
	// Since we can't use ==, we'll use reflect.DeepEqual
	// which is a recursive relaxation of Go's == operator.
	//
	// We can also use the Equal() function from the
	// slices package itself.
	if !slices.Equal(got, want) {
		t.Errorf("\n Got: %v \n Wanted: %v", got, want)
	}
}

func TestSumAllTails(t *testing.T) {

	checkSums := func(t testing.TB, got, want []int) {
		t.Helper()
		if !reflect.DeepEqual(got, want) {
			t.Errorf("\n Got: %v \n Wanted: %v", got, want)
		}
	}

	t.Run("Sum of non-empty slices", func(t *testing.T) {
		got := SumAllTails([]int{1, 2}, []int{3, 4, 5})
		want := []int{2, 9}

		checkSums(t, got, want)
	})

	t.Run("Sum of empty slices", func(t *testing.T) {
		got := SumAllTails([]int{}, []int{})
		want := []int{}

		checkSums(t, got, want)
	})
}
