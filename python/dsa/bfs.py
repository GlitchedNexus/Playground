# Ideal for finding the shortest path or
# exploring nodes layer by layer.

from collections import deque


def bfs(root):
    queue = deque([root])
    visited = set([root])  # used when cycles can be a thing

    while len(queue) > 0:
        node = queue.popleft()
        for neighbour in get_neighbours(node):
            if neighbour in visited:
                continue
            queue.append(neighbour)
            visited.add(neighbour)


class Node:
    def __init__(self, val, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


def get_neighbours(node: Node) -> list[Node]:
    if node.left and node.right:
        return [node.left, node.right]
    elif node.left:
        return [node.left]
    elif node.right:
        return [node.right]
    else:
        return []


def level_order_traversal(root: Node) -> list[list[int]]:
    res = []
    queue = deque([root])
    while len(queue) > 0:
        n = len(queue)
        level_list = []
        for _ in range(n):
            node = queue.popleft()
            level_list.append(node.val)
            for child in [node.left, node.right]:
                if child is not None:
                    queue.append(child)
        res.append(level_list)
    return res


def flood_fill(
    r: int, c: int, replacement: int, image: list[list[int]]
) -> list[list[int]]:
    num_rows, num_cols = len(image), len(image[0])

    def get_neighbours(coord: tuple[int, int], color):
        row, col = coord
        delta_row = [-1, 0, 1, 0]
        delta_col = [0, 1, 0, -1]

        for i in range(len(delta_row)):
            neighbour_row = row + delta_row[i]
            neighbour_col = col + delta_col[i]

            if 0 <= neighbour_row < num_rows and 0 <= neighbour_col < num_cols:
                if image[neighbour_row][neighbour_col] == color:
                    yield neighbour_row, neighbour_col

    def bfs(root):
        queue = deque([root])
        visited = [[False for c in range(num_cols)] for r in range(num_rows)]
        r, c = root
        color = image[r][c]
        image[r][c] = replacement
        visited[r][c] = True
        while len(queue) > 0:
            node = queue.popleft()
            for neighbour in get_neighbours(node, color):
                r, c = neighbour
                if visited:
                    continue
                image[r][c] = replacement
                queue.append(neighbour)
                visited[r][c] = True

    bfs((r, c))
    return image
