% =========================================
% Prolog Lab – Intelligent Maze Advisor
% =========================================
% Summary:
% We model the maze as a graph with edge/2 facts and blocked/2 possible constraints.
% The can_move/2 predicate allows moving if there is an edge and it is not blocked.
% The recursive search move/4 maintains a visited list to avoid loops and,
% at each step, prints explanations (“Moving…”, “Exploring…”). The predicate
% find_path/3 invokes the search and returns the path in origin→destination order.


% ---------- 1) Graph ----------
edge(entrance, a).
edge(a, b).
edge(a, c).
edge(b, exit).
edge(c, b).

% The blocked path
blocked(a, c).

% ---------- 2)Rules ----------
can_move(X, Y) :-
    edge(X, Y),
    \+ blocked(X, Y).

% Simple explain between nodes
reason(X, Y, 'path is open')    :- can_move(X, Y), !.
reason(X, Y, 'path is blocked') :- edge(X, Y), blocked(X, Y), !.
reason(_, _,  'no direct edge').

% ---------- 3) Recursive traversal with traces ----------
% First Case: Where there is a valid direct jump X->Y
move(X, Y, Visited, [Y|Visited]) :-
    can_move(X, Y),
    format('Moving from ~w to ~w.~n', [X, Y]), !.

% Caso: explorar vecino Z no visitado
move(X, Y, Visited, Path) :-
    can_move(X, Z),
    \+ member(Z, Visited),
    format('Exploring from ~w to ~w...~n', [X, Z]),
    move(Z, Y, [Z|Visited], Path).


find_path(From, To, Path) :-
    move(From, To, [From], Rev),
    reverse(Rev, Path).

% Why for two nodes
why(X, Y) :-
    reason(X, Y, R),
    format('Reason from ~w to ~w: ~w~n', [X, Y, R]).

