# Perfect for monotonic data.

# Works for any monotonic function and
# requires sorted input
from json.encoder import INFINITY


def binary_search(nums: list[int], target: int) -> int:

    left, right = 0, len(nums) - 1

    while left <= right:
        middle = (left + right) // 2
        if nums[middle] == target:
            return middle
        elif nums[middle] > target:
            right = middle - 1
        else:
            left = middle + 1

    return -1


# print(binary_search([1, 2, 3, 4, 5, 6, 7], 3))


# Good when we are trying to find the first valid solution.
# def binary_search_feasible(arr: list[int]) -> int:
#     left, right = 0, len(arr) - 1

#     first_true_index = -1

#     while left <= right:
#         mid = (left + right) // 2
#         if feasible(mid):
#             first_true_index = mid
#             right = mid - 1
#         else:
#             left = mid + 1

#     return first_true_index


def first_true(arr: list[bool]) -> int:
    left, right = 0, len(arr) - 1

    first_true_index = -1

    while left <= right:
        middle = (left + right) // 2
        if arr[middle]:
            first_true_index = middle
            right = middle - 1
        else:
            left = middle + 1
    return first_true_index


# print(first_true([True]) == 0)
# print(first_true([False, True]) == 1)
# print(first_true([False, False, False, True]) == 3)
# print(first_true([False, False, False, True, True, True]) == 3)
# print(first_true([False, False]) == -1)


def find_min(arr: list[int]) -> int:
    left, right = 0, len(arr) - 1
    min_index = right

    while left <= right:
        middle = (left + right) // 2
        if arr[middle] <= arr[-1]:
            min_index = middle
            right = middle - 1
        else:
            left = middle + 1
    return min_index


print(find_min([3, 4, 5, 1, 2]))
