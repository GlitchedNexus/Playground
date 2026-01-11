from collections import deque
import queue

class Node:
    children = []
    value = None


NOT_FOUND = -1

def bfs(root: Node):

    queue = deque([root])

    while len(queue) > 0:
        node = queue.popleft()

        for child in node.children:
            if OK(child):
                return FOUND(child)
            queue.append(child)

    return NOT_FOUND


def OK(child: Node):
    pass

def FOUND(child: Node):
    pass
