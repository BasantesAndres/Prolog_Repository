# Prolog Lab 3 – Graph Traversal (Submission Package)

**Date:** 2025-10-13

This package contains everything required for the deliverables:

## Files
- `lab03pl` → Graph representation, path-finding with cycle handling, and demo queries.
- `Written_Answers_Lab03.md` → Template to paste screenshots of successful queries and write short answers.
- `Demo part 1-4` → Demo queries part 1 to 4.
- `Extra Querie ( patch naive) and  listing edge` → Extra querie with path native and listing edge _ c.
---

## How to run (Windows PowerShell)

1. Open PowerShell in this folder.
2. **Interactive mode** (for demos):
   ```powershell
   swipl
   ?- [lab03].
   ?- demo_part1.
   ?- path_c_naive(a,c).   % show it hangs, then Ctrl+C, 'a' to abort (proof of cycle)
   ?- demo_part2.
   ?- demo_part3.
   ?- demo_part4.
   ```

## Mapping to deliverables

### 1) Graph representation
- Predicates: `edge/2` (acyclic baseline), `edge_c/2` (cyclic version), `door/2` for maze.
- File: `lab03_graph_traversal.pl` (Part 1, Part 2, and Part 4 sections).

### 2) Path-finding with cycle handling
- Unsafe: `path_c_naive/2` (demonstrates infinite recursion on cyclic graph).
- Safe with visited list: `path_safe/3`, `path_list/3` (returns actual node list).
- Shortest path bonus (BFS): `shortest_path/3`.

### 3) Queries demonstrating paths
Run and capture:
- `demo_part1.`  → reachability in acyclic graph.
- `path_c_naive(a,c).`  → shows the cycle issue (abort with Ctrl+C → `a`).  
- `demo_part2.`  → safe path and a concrete route printed.
- `demo_part3.`  → **all** paths collected with `findall/3`.
- `demo_part4.`  → maze path and (bonus) shortest path.

---
