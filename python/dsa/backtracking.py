def dfs(start_index, path, [...additional_states]):
    if is_leaf(start_index):
        ans.append(path[:])

    for edge in get_edges(start_index, [...additional_states]):
        #prune if needed
        if not is_valid(edge):
            continue
        path.add(edge)
        if additional states:
            update(... aditional states)
        dfs(start_index + len(edge), path, [...additional_states])
        # revert(...aditional states) only if necessary e.g. permutations.
        path.pop()
