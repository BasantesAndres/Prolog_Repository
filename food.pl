likes(alicia, pizza).
likes(alicia, pasta).
likes(bob, pizza).
likes(bob, hamburger).
likes(charlie, sushi).
likes(charlie, pizza).
likes(diana, pasta).
likes(diana, salad).
likes(emma, sushi).
likes(emma, ice_cream).


%Rule: likes the same food.%

food_friend(X, Y) :- likes(X, Food), likes(Y, Food), X \= Y.