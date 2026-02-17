# Let's us save results as we go

# Basic Code Structure
# of a frequency map
# This is the most common pattern.

data = []  # placeholder
my_map = {}

for item in data:
    if item not in my_map:
        my_map[item] = 1
    else:
        my_map[item] += 1


# Two Sum
nums = [1, 2, 3, 4, 5, 6]
target = 5


def two_sum(nums: list[int], target: int) -> list[int] | None:
    map = {}

    for i, num in enumerate(nums):
        complement = target - num

        if complement in map:
            return [map[complement], i]
        else:
            map[nums[i]] = i

    return None


print(two_sum(nums, target))
