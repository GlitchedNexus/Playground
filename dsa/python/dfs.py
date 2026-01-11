# Most often use the call stack because most
# implementations use recursion.
#
# Best for exploring all paths or checking
# every possible configurations.
#
# Does not guarantee finding the closest
# solution first.


class Node:
    children = []
    value = None

def dfs(root: Node) -> List[Node]:

    nodes = []

    for child in root.children:
        if OK(child)
            return FOUND(child)
        dfs(child)

    return NOT_FOUND

NOT_FOUND = -1

def OK(child: Node):
    pass

def FOUND(child: Node):
    pass
