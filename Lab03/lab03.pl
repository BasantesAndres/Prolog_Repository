% =============================================
% Prolog Lab 3: Graph Traversal (Complete Tutorial Solution)
% File: lab03.pl
% =============================================

% -------------------------------
% Part 1 – Basics (edges + naive path)
% -------------------------------

% Directed graph (acyclic baseline)
edge(a,b).
edge(b,c).
edge(a,d).
edge(d,c).

% Naive reachability (may loop on cyclic graphs)
path_naive(X,Y) :- edge(X,Y).
path_naive(X,Y) :- edge(X,Z), path_naive(Z,Y).

% Handy demo for Part 1
demo_part1 :-
    writeln('--- Part 1: Basics (acyclic graph) ---'),
    ( path_naive(a,c) -> writeln('Is there a path from a to c? yes.') ; writeln('Is there a path from a to c? no.') ),
    ( path_naive(b,a) -> writeln('Is there a path from b to a? yes.') ; writeln('Is there a path from b to a? no.') ),
    nl.

% -------------------------------
% Part 2 – Cycles (show risk + fix with visited list)
% -------------------------------

% Same graph but with a cycle c -> a
edge_c(a,b).
edge_c(b,c).
edge_c(a,d).
edge_c(d,c).
edge_c(c,a).  % creates a cycle

% Naive reachability over the cyclic graph (WARNING: can loop)
path_c_naive(X,Y) :- edge_c(X,Y).
path_c_naive(X,Y) :- edge_c(X,Z), path_c_naive(Z,Y).

% Safe reachability: keep a visited list to avoid cycles
path_safe(X,Y) :- path_safe(X,Y,[X]).
path_safe(Y,Y,_) :- !.
path_safe(X,Y,Visited) :-
    edge_c(X,Z),
    \+ member(Z,Visited),
    path_safe(Z,Y,[Z|Visited]).

% Variant that returns the actual path (as a list of nodes)
path_list(Start, End, Path) :-
    path_list_(Start, End, [Start], Rev),
    reverse(Rev, Path).

path_list_(End, End, Acc, Acc).
path_list_(Curr, End, Acc, Path) :-
    edge_c(Curr, Next),
    \+ member(Next, Acc),
    path_list_(Next, End, [Next|Acc], Path).

% -------------------------------
% Part 3 – Listing all paths with findall/3
% -------------------------------

all_paths(Start, End, Paths) :-
    findall(P, path_list(Start, End, P), Paths).

print_paths([]) :- writeln('No paths found.'), !.
print_paths([P|Ps]) :-
    write('Path: '), writeln(P),
    print_paths(Ps).

demo_part3 :-
    writeln('--- Part 3: All paths from a to c on the cyclic graph ---'),
    all_paths(a,c,Paths),
    print_paths(Paths), nl.

% -------------------------------
% Part 4 – Student Extension (Maze example)
% -------------------------------

% A tiny maze; undirected connections modeled as two directed edges
door(r1,r2). door(r2,r1).
door(r2,r3). door(r3,r2).
door(r3,r4). door(r4,r3).
door(r2,r5). door(r5,r2).
door(r5,r6). door(r6,r5).

entrance(r1).
exit(r6).

% General path over maze using door/2 with visited list, returning path
maze_path(Path) :-
    entrance(S), exit(E),
    maze_path(S,E,Path).

maze_path(Start, End, Path) :-
    maze_path_(Start, End, [Start], Rev),
    reverse(Rev, Path).

maze_path_(End, End, Acc, Acc).
maze_path_(Curr, End, Acc, Path) :-
    door(Curr, Next),
    \+ member(Next, Acc),
    maze_path_(Next, End, [Next|Acc], Path).

% Bonus: shortest path via BFS (guarantees minimal hops)
shortest_path(Start, End, Shortest) :-
    bfs_([[Start]], End, Rev),
    reverse(Rev, Shortest).

bfs_([[End|Rest]|_], End, [End|Rest]) :- !.
bfs_([Path|Qs], End, Sol) :-
    Path = [Head|_],
    findall([Next|Path],
            ( neighbor_(Head, Next),
              \+ member(Next, Path) ),
            NewPaths),
    append(Qs, NewPaths, Qs2),
    bfs_(Qs2, End, Sol).

% neighbors for BFS on the cyclic graph edge_c/2 and the maze door/2
neighbor_(X,Y) :- edge_c(X,Y).
neighbor_(X,Y) :- door(X,Y).

% Demos for Part 2 and 4
demo_part2 :-
    writeln('--- Part 2: Cycles and safe traversal ---'),
    writeln('Try: path_c_naive(a,c).  % this may not terminate due to cycle.'),
    ( path_safe(a,c) -> writeln('Safe path from a to c exists.') ; writeln('No safe path from a to c.') ),
    path_list(a,c,P), write('One concrete path a->c: '), writeln(P), nl.

demo_part4 :-
    writeln('--- Part 4: Maze path & shortest path (bonus) ---'),
    maze_path(P), write('Maze path (entrance->exit): '), writeln(P),
    shortest_path(r1, r6, S), write('Maze shortest path r1->r6: '), writeln(S), nl.

% -------------------------------
% Helper to run everything quickly
% -------------------------------
demo_all :-
    demo_part1,
    demo_part2,
    demo_part3,
    demo_part4.

% End of file
