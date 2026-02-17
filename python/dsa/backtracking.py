# We need to find all possible paths or arrangements.
#
# Try all the ways for x and only the return the valid ones.
#
# ans = []
# def dfs(start_index, path, [... additional states]):
#     if is_leaf(start_index):
#         ans.append(path[:])
#         return
#     for edge in get_edges(start_index, [... additional states]):
#         # prune if needed
#         if not is_valid(edge):
#             continue
#         path.add(edge)
#         if additional_states:
#             update(... additional states)
#         dfs(start_index + len(edge), path, [... additional states])
#         # revert (... additional states) if necessary. e.g. permutations
#         path.pop()


def exist(board: list[list[str]], word) -> bool:
    result = []

    num_rows = len(board)
    num_cols = len(board[0])

    def dfs(i, j, word_i):
        if board[i][j] != word[word_i]:
            return False
        if word_i == len(word) - 1:
            return True
        char = board[i][j]
        board[i][j] = "*"
        coords = [(i - 1, j), (i, j - 1), (i + 1, j), (i, j + 1)]
        for r, c in coords:
            if 0 <= r < num_rows and 0 <= c < num_cols:
                if dfs(r, c, word_i + 1):
                    return True
        board[i][j] = char
        return False

    for r in range(num_rows):
        for c in range(num_cols):
            if dfs(r, c, 0):
                return True

    return False

    return result
