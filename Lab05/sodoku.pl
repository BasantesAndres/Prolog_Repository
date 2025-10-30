% -------------------------------------------
% Lab 05
% 29/10/2025
% Sodoku 9x9 
% Basantes Andres
% Prof. Pineda
% library: (clpfd)
% - 0 in the input means is a empty.
% -------------------------------------------


:- use_module(library(clpfd)).

% sudoku(+Grid) succeeds when Grid is a solved 9x9 Sudoku matrix.
sudoku(Grid) :-
    length(Grid, 9),
    maplist(length_is_9, Grid),
    append(Grid, Vars),
    Vars ins 1..9,

    % Row constraints
    maplist(all_distinct, Grid),

    % Column constraints
    transpose(Grid, Cols),
    maplist(all_distinct, Cols),

    % 3x3 block constraints
    blocks_ok(Grid),

    % Search (assign values)
    label(Vars).

length_is_9(Row) :- length(Row, 9).

% Enforce all_distinct on each 3x3 block
blocks_ok([]).
blocks_ok([A,B,C|Rest]) :-
    blocks3(A,B,C),
    blocks_ok(Rest).

blocks3([], [], []).
blocks3([A1,A2,A3|As], [B1,B2,B3|Bs], [C1,C2,C3|Cs]) :-
    all_distinct([A1,A2,A3,B1,B2,B3,C1,C2,C3]),
    blocks3(As, Bs, Cs).

% Convert 0s (empty cells) to fresh variables
zeros_to_vars([], []).
zeros_to_vars([Row|Rs], [Row2|Rs2]) :-
    maplist(z2v, Row, Row2),
    zeros_to_vars(Rs, Rs2).

z2v(0, _) :- !.       
z2v(N, N) :- N \= 0.   


% 0 becomes a variable
% non-zero stays the same

% Pretty print as a 9x9 grid
pretty(Grid) :-
    writeln('---------------------'),
    print_rows(Grid, 1).

print_rows([], _) :- !.
print_rows([R|Rs], I) :-
    format('| ~w ~w ~w | ~w ~w ~w | ~w ~w ~w |~n', R),
    ( I mod 3 =:= 0 ->
        writeln('---------------------')
    ;   true
    ),
    I2 is I + 1,
    print_rows(Rs, I2).

% Example puzzle (0 = empty). Replace this with your own if needed.
example([
  [5,3,0, 0,7,0, 0,0,0],
  [6,0,0, 1,9,5, 0,0,0],
  [0,9,8, 0,0,0, 0,6,0],

  [8,0,0, 0,6,0, 0,0,3],
  [4,0,0, 8,0,3, 0,0,1],
  [7,0,0, 0,2,0, 0,0,6],

  [0,6,0, 0,0,0, 2,8,0],
  [0,0,0, 4,1,9, 0,0,5],
  [0,0,0, 0,8,0, 0,7,9]
]).

% solve this example and print
solve_example :-
    example(P),
    zeros_to_vars(P, V),
    sudoku(V),
    pretty(V).

% solve any custom puzzle P (list of 9 lists)
solve_custom(P) :-
    zeros_to_vars(P, V),
    sudoku(V),
    pretty(V).

:- initialization(main, main).
main :-
    solve_example,
    halt.






