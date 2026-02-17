# Most often use the call stack because most
# implementations use recursion.
#
# Best for exploring all paths or checking
# every possible configurations.
#
# Does not guarantee finding the closest
# solution first.


class Node:
    def __init__(self, val, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


# DFS For Trees
def dfs(root, target):
    if root is None:
        return None
    if root.val == target:
        return root
    left = dfs(root.left, target)
    if left is not None:
        return left
    return dfs(root.right, target)


# DFS For Graphs
def dfs_graphs(root, visited):

    def get_neighbours(root):
        return []

    for neighbour in get_neighbours(root):
        if neighbour in visited:
            continue
        visited.add(neighbour)
        dfs_graphs(neighbour, visited)


def max_depth(root: Node | None) -> int:
    if root is None:
        return 0
    return (
        1
        + max(
            max_depth(root.left),
            max_depth(root.right),
        )
        - 1
    )  # assuming root is depth 0


def count_number_islands(grid: list[list[int]]) -> int:
    num_rows = len(grid)
    num_cols = len(grid[0])

    def get_neighbours(coord: tuple[int, int]):
        res = []
        row, col = coord
        delta_row = [1, 0, -1, 0]
        delta_col = [0, 1, 0, -1]
        for i in range(len(delta_row)):
            r = row + delta_row[i]
            c = col + delta_col[i]
            if 0 <= r < num_rows and 0 <= c < num_cols:
                res.append((r, c))

        return res

    def dfs(coord):
        r, c = coord
        if grid[r][c] == 0:
            return
        grid[r][c] = 0
        for neighbour in get_neighbours((r, c)):
            nr, nc = neighbour
            if grid[nr][nc] == 1:
                dfs(neighbour)

    count = 0
    for r in range(num_rows):
        for c in range(num_cols):
            if grid[r][c] == 1:
                dfs((r, c))
                count += 1

    return count
