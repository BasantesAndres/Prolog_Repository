parent(john, mary).
parent(john, peter).
parent(mary, susan).
parent(mary, bob).
parent(peter, lisa).
parent(peter, david).
parent(susan, alice).
parent(susan, charlie).
parent(bob, emma).
parent(bob, oliver).
parent(lisa, sophia).
parent(david, noah).

% Rules relationships %

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y.

% Ancestor %
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).