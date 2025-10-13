# Written Answers – Prolog Lab 3 
---

## 1) Part 1 – Basics (acyclic graph)
- **Query:** `demo_part1.`
- **Notes:** Confirms there is a path `a -> c` and no path `b -> a` in the acyclic graph.

## 2) Part 2 – Cycles & Safe Traversal
- **Query (problem):** `path_c_naive(a,c).` → press `;` to request another solution until it hangs, then **Ctrl+C** and `a` to abort.
- **Query (fix):** `demo_part2.`
- **Notes:** The safe version avoids infinite recursion by keeping a **visited** list and also prints a concrete route.

## 3) Part 3 – All paths using `findall/3`
- **Query:** `demo_part3.`
- **Notes:** Lists all distinct paths (e.g., `[a,b,c]` and `[a,d,c]`) collected with `findall/3`.

## 4) Part 4 – Maze & Shortest Path (bonus)
- **Query:** `demo_part4.`
- **Notes:** `maze_path/1` returns a valid route from entrance to exit; `shortest_path/3` (BFS) guarantees the minimum number of hops.

---
