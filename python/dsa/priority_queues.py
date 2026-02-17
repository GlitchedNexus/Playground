# Usually implemented as binary heaps

from heapq import heapify, heappop, heappush


def k_closest_points(points: list[list[int]], k: int) -> list[list[int]]:
    heap: list[tuple[int, list[int]]] = []

    for pt in points:
        # Heaps in python use the first item in the tuple
        # to figure out the priority
        heappush(heap, (pt[0] ** 2 + pt[1] ** 2, pt))

    res = []
    for _ in range(k):
        _, pt = heappop(heap)
        res.append(pt)

    return res


def kth_largest_element(nums: list[int], k: int) -> int:
    heapify_max(nums)
    for _ in range(k - 1):
        heappop(nums)
    return heappop(nums)


print(kth_largest_element([1, 2, 3, 4, 4, 5, 6, 67, 8, 89], 3))
