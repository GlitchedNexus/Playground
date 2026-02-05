from ast import Return
import math
from collections import deque
import heapq

for i in range(5, 1, -2):
    print(i)

print(math.fmod(-10, 3))

print(math.floor(3.2))
print(math.ceil(3.2))
print(math.sqrt(3.2))
print(math.pow(3,2))

float("inf")
float("-inf")

arr = [1,2,3]
arr.append(1)
print(arr)
print(arr.pop())

arr.insert(1, 7)
print(arr)

arr[0] = 1 # constant time operation

arr[-1] = 3

print(arr[1:3])
print(arr[:])
print(arr[::-1])


a,b,c,d = arr
print(a,b,c,d)

nums = [1,2,3]

for i in range(len(nums)):
    print(nums[i])

for i in nums:
    print(i)

for i, n in enumerate(nums):
    print(f"index {i}: {n}")

nums1 = [1,2,3]
nums2 = [4,5,6]

for i, (n1, n2) in enumerate(zip(nums1, nums2)):
    print(i, n1, n2)

arr.reverse()
print(arr)
print(arr.sort())

names = ["bob", "alice", "jane", "doe"]
names.sort(key=lambda x: len(x))

arr = [i for i in range(5)]
print(arr)
arr = [2*i for i in range(5)]

arr = [[i] * 4 for i in range(4)]

s ="abc"
# updating strings will create a new string
# since strings are considered immutable
# string manilpulation is considered O(n)

print(str(123) + str(123))

print(ord("a"))

strings = ["a", "b", "c"]
print(" ".join(strings))


queue = deque()
queue.append(1)
queue.append(2)
queue.pop()

mapping = {}

mapping["alice"] = 77

print(mapping.pop("alice"))

myMap = { i: 2*i for i in range(3)}

for k in myMap.keys():
    print(k)

for v in myMap.values():
    print(v)

for k, v in myMap.items():
    print(k,v)

# tuples cannot be modified
# we can therefore use them as keys
# for hashsets and hasmaps
myMap = {}

# heaps in pyton are min heaps by default
# heaps are implemented with arrays
# Min is always at index 0
heap = []
heapq.heappush(heap, 3)
heapq.heappush(heap, 2)
heapq.heappush(heap, 4)

print(heap[0])

while len(heap):
    print(heapq.heappop(heap))

# since there are no max heaps we multiply each
# value by -1 and when we pop we multiply that
# value by -1 again
maxHeap = []
heapq.heappush(maxHeap, -1*2)
heapq.heappush(maxHeap, -1*3)
heapq.heappush(maxHeap, -1*4)
heapq.heappush(maxHeap, -1*5)

print(-1 * maxHeap[0])

arr = [2,1,3,67,8]
heapq.heapify(arr)
while arr:
    print(heapq.heappop(arr))

def myFunc(n,m):
    print(n*m)

def outer(a,b):
    c = "hi"
    def inner():
        print(c)

    inner()

# You can modify objects but not reassign
# unless using nonlocal keywords
def double(arr, val):
    def helper():
        for i, n in enumerate(arr):
            arr[i] *= 2

            # val *= 2 only modifies the
            # val in the helper's scope
            #
            # to modify val outside the
            # helper's scope we can use nonlocal
            nonlocal val
            val *= 2
    helper()
    print(arr, val)

nums = [1,2]
val = 3
double(nums, val)

class MyClass:
    def __init__(self, nums):
        self.nums = nums
        self.size = len(nums)

    def getLength(self):
        return self.size

    def getDoubleLength(self):
        return 2 * self.getLength()

ex = MyClass([1,2,3,])
print(ex.getLength())
print(ex.getDoubleLength())
