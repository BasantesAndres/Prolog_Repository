% Length
length_list([], 0).
length_list([_|Tail], Length) :-
    length_list(Tail, TailLength),
    Length is TailLength + 1.

% Union

append_list([], List, List).
append_list([Head|Tail], List2, [Head|Result]) :-
    append_list(Tail, List2, Result).

% Member list
member(X, [X|_]).
member(X, [_|Tail]) :- member(X, Tail).