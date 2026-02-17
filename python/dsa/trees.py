from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def invertTree(self, root: TreeNode | None) -> TreeNode | None:
        if root is None:
            return None

        queue = deque([root])

        while len(queue) > 0:
            node = queue.popleft()
            node.left, node.right = node.right, node.left
            for i in [node.right, node.left]:
                if i is not None:
                    queue.append(i)

        return root
