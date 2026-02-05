# Works for any monotonic function and
# requires sorted input
def binary_search(nums: list[int], target: int) -> int:

    left, right = 0, len(nums) - 1

    first_true_index = -1

    while left <= right:
        middle = (left + right) // 2
        if (nums[middle] == target):
            return middle
        elif (nums[middle] > target):
            right = middle - 1
        else:
            left = middle + 1

    return -1

print(binary_search([1,2,3,4,5,6,7], 3))
