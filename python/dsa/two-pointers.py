# Same direction pponters are ideal for situations
# where we're processiing or scanning the data in
# a single pass.
#
# Use case: the fast and slow pointer approach for
#           detecting cycles in linked lists or
#           finding the middle of the list.
#
# For pointers moving in the same direction
#
# We use two indeces to avoid nested loops and
# repeated scanning.
#
# 1. Same direction
# Usually used when doing a single pass of the data
# The fast and slow pointer pattern is good
#
# 2. Different direction


def is_palindrome(text: str) -> bool:

    left, right = 0, len(text) - 1

    while left <= right:
        while left <= right and not text[left].isalnum():
            left += 1
        while left <= right and not text[right].isalnum():
            right -= 1

        if text[left] != text[right]:
            return False
        left += 1
        right -= 1
    return True


print(is_palindrome("asdfgfdsa"))
print(is_palindrome("asdff  dsa"))
print(is_palindrome("asfdsa"))
print(is_palindrome("afdsa"))


class Node:
    def __init__(self, val, next=None) -> None:
        self.val = val
        self.next = next


def middle_of_linked_list(head: Node) -> Node:
    slow, fast = head, head

    while fast and fast.next:
        fast = fast.next.next
        slow = slow.next

    return slow.val
