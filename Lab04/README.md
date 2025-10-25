# 🧭 Intelligent Maze Advisor (Prolog)

An explainable path-finding toy agent written in Prolog.  
It models a maze as a graph, reasons about permissible moves, explores with recursion while **printing human-friendly explanations**, and returns a complete path from a start node to a goal node.


## Overview

- The maze is a **directed graph** using facts like `edge(X, Y).`
- Some doors/edges can be **blocked** with `blocked(X, Y).`
- The agent can move from `X` to `Y` iff there is an edge and it’s not blocked (`can_move/2`).
- The search uses recursion with a **visited list** to avoid loops and **prints explanations**:
  - `Moving from X to Y.` (direct step to the goal)
  - `Exploring from X to Z...` (trying a neighbor on the way)
- The main query is `find_path(From, To, Path).` which returns the path and prints the trace.

---

## Repository Structure

```
prolog-maze/
├─ maze_advisor.pl            # Main Prolog source 
├─ Maze advisor screen 1.png   # Console screenshot showing the trace 
└─ README.md                  # This file
```



## Quick Start

### Run in SWI-Prolog GUI

1. Open **SWI-Prolog**.
2. Load the file:
   ```prolog
   ?- [maze_advisor].
   ```
3. Run the path query:
   ```prolog
   ?- find_path(entrance, exit, Path).
   ```
4. Observe the printed reasoning and final `Path = [...]`.

> Take a screenshot of the console output (include the Moving/Exploring lines and the Path). Save it as `screenshot_reasoning.png`.

### Run from Terminal

From the project directory:

```bash
swipl
```

Then in the Prolog REPL:

```prolog
?- [maze_advisor].
?- find_path(entrance, exit, Path).
```


---

## Example Session & Expected Output

**Query:**
```prolog
?- [maze_advisor].
?- find_path(entrance, exit, Path).
```

**Typical console trace:**
```
Moving from entrance to a.
Exploring from a to b...
Moving from b to exit.
Path = [entrance,a,b,exit].
```

**Optional “why” checks:**
```prolog
?- why(a, b).
Reason from a to b: path is open
true.

?- why(a, c).
Reason from a to c: path is blocked
true.
```

---

