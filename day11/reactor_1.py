def all_simple_paths(graph, start, goal):
    result = []
    visited = set()
    path = []

    def dfs(u):
        if u in visited:
            return

        visited.add(u)
        path.append(u)

        if u == goal:
            result.append(list(path))
        else:
            for v in graph.get(u, []):
                dfs(v)

        path.pop()
        visited.remove(u)

    dfs(start)
    return result

lines = [line.strip().split(':') for line in open("input.txt","r").readlines()]
graph = dict()
for line in lines:
    graph[line[0]] = line[1].strip().split(" ")

res = all_simple_paths(graph, "you", "out")
print(len(res))
