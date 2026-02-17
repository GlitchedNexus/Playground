# We adjust size of window as needed,
# never revisit data and get O(n).
#
# Two types:
# 1. Fixed size window
# def fixed_sliding_window(input, window_size):
#     ans = window = input[0:window_size]

#     for right in range(window_size, len(input)):
#         left = right - window_size
#         remove input[left] from window
#         append input[right] to window
#         ans = optimal(ans, window)
#     return ans
#
# 2. Dynamic size window
# def dynamic_sliding_window(input):
#     initialize window, ans
#     left = 0
#     for right in range(len(input)):
#         append input[right] to window
#         while invalid(window): # update left until window is valid again
#             remove input[left] from sliding
#             left += 1
#         ans = max(ans, window) # window is guaranteed to be valid here
#     return ans


# def find_longest_subarray_of_len_k(input: list[int], k: int) -> int:
#     length = len(input)

#     if length < k:
#         return -1

#     left, right = 0, k - 1
#     ans = sum(input[left : right + 1])

#     while right < length:
#         left += 1
#         right += 1
#         ans = max(ans, sum(input[left : right + 1]))
#     return ans


from typing_extensions import DefaultDict


def find_longest_subarray_of_len_k(input: list[int], k: int) -> int:
    window_sum = 0
    left, right = 0, k - 1

    for i in range(k):
        window_sum += input[i]

    largest = window_sum

    for i in range(k, len(input)):
        left = right - i
        window_sum -= input[left]
        window_sum += input[right]
        largest = max(largest, window_sum)

    return largest


print(find_longest_subarray_of_len_k([1, 2, 3, 4, 5], 5))


# def longest_substring(input: str) -> str:
#     if input == "":
#         return ""

#     length = len(input)
#     left, right = 0, 0
#     window = input[left : right + 1]
#     longest = input[left : right + 1]
#     while right < length:
#         right += 1
#         window = input[left : right + 1]
#         while len(window) != len(set(window)):
#             left += 1
#             window = input[left : right + 1]
#         if len(longest) < len(window):
#             longest = window
#     return longest


def longest_substring(input: str) -> int:
    longest = 0
    l = 0
    counter: dict[str, int] = DefaultDict(int)
    for r in range(len(input)):
        counter[input[r]] += 1
        while counter[input[r]] > 1:
            counter[input[l]] -= 1
            l += 1
        longest = max(longest, r - l + 1)
    return longest


print(longest_substring("abcdbea") == 5)
print(longest_substring("abcde") == 5)
print(longest_substring("") == 0)
print(longest_substring("aaaaaaa") == 1)
# print(longest_substring("abcdbea") == "cdbea")
# print(longest_substring("abcde") == "abcde")
# print(longest_substring("") == "")
# print(longest_substring("aaaaaaa") == "a")
