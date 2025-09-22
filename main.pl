

:- [family, food, math_utils, list_utils].

% Consult queries %
run_all_queries :-
    write('Consults'), nl, nl,
    
    % 1. Ancestors of a specific person
    write('1. Ancestor alice:'), nl,
    findall(Ancestor, ancestor(Ancestor, alice), Ancestors),
    write(Ancestors), nl, nl,
    
    % 2. Siblings/brothers
    write('2. All siblings/brothers that same tree:'), nl,
    findall((X, Y), sibling(X, Y), Siblings),
    write(Siblings), nl, nl,
    
    % 3. Food friends
    write('3. Food friends:'), nl,
    findall((X, Y, Food), (food_friend(X, Y), likes(X, Food)), FoodFriends),
    write(FoodFriends), nl, nl,
    
    % 4. Factorial of six
    write('4. Factorial of 6:'), nl,
    factorial(6, Fact6),
    write(Fact6), nl, nl,
    
    % 5. Addition [2,4,6,8]
    write('5. Addition of [2,4,6,8]:'), nl,
    sum_list([2,4,6,8], Sum),
    write(Sum), nl, nl,
    
    % 6. lenght [a,b,c,d]
    write('6. lenght de [a,b,c,d]:'), nl,
    length_list([a,b,c,d], Length),
    write(Length), nl, nl,
    
    % 7. Append of [1,2] y [3,4]
    write('7. Append of [1,2] y [3,4]:'), nl,
    append_list([1,2], [3,4], Result),
    write(Result), nl.