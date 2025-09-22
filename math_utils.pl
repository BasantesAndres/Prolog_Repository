% Factorial
factorial(0, 1).
factorial(N, Result) :- 
    N > 0, 
    N1 is N - 1, 
    factorial(N1, Result1), 
    Result is N * Result1.

% Sum lits%
sum_list([], 0).
sum_list([Head|Tail], Sum) :-
    sum_list(Tail, TailSum),
    Sum is Head + TailSum.