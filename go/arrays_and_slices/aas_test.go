package arraysandslices

import "testing"

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
