% ====================================
% ANIMAL IDENTIFICATION EXPERT SYSTEM
% ====================================

% ====================================
% STEP 1: KNOWLEDGE BASE - FACTS
% ====================================

% Basic animal properties
has_fur(cat).
has_fur(dog).
has_fur(horse).
has_fur(rabbit).

lays_eggs(chicken).
lays_eggs(duck).
lays_eggs(eagle).
lays_eggs(penguin).
lays_eggs(ostrich).
lays_eggs(turtle).

barks(dog).
meows(cat).
neighs(horse).

% Additional properties
flies(eagle).
flies(chicken).  % although flies poorly
swims(duck).
swims(penguin).
swims(turtle).

is_domesticated(cat).
is_domesticated(dog).
is_domesticated(horse).
is_domesticated(chicken).
is_domesticated(rabbit).

is_large(horse).
is_large(eagle).
is_large(ostrich).

is_carnivore(cat).
is_carnivore(dog).
is_carnivore(eagle).

% ====================================
% STEP 2: CLASSIFICATION RULES
% ====================================

% Basic classification rules
is_mammal(X) :- has_fur(X).
is_bird(X) :- lays_eggs(X), flies(X).
is_bird(X) :- lays_eggs(X), \+ has_fur(X).

can_fly(X) :- flies(X).
can_swim(X) :- swims(X).

% Hierarchical classification
is_vertebrate(X) :- is_mammal(X).
is_vertebrate(X) :- is_bird(X).
is_vertebrate(X) :- lays_eggs(X).

% ====================================
% STEP 3: INTERACTIVE QUESTION SYSTEM
% ====================================

% Predicate to ask questions
ask(Question, Answer) :-
    write('Does it '), write(Question), write('? (yes/no): '),
    read(Answer).

% Predicate for multiple choice questions
ask_multiple(Question, Options, Answer) :-
    write('What '), write(Question), write('?'), nl,
    write('Options: '), write(Options), nl,
    write('Your answer: '),
    read(Answer).

% ====================================
% STEP 4: MAIN INFERENCE ENGINE
% ====================================

identify_animal(Animal) :-
    write('=== ANIMAL IDENTIFICATION EXPERT SYSTEM ==='), nl,
    write('Answer the questions to identify the animal.'), nl, nl,
    
    % Main question: does it have fur?
    ask('have fur or hair', HasFur),
    
    (HasFur == yes ->
        identify_mammal(Animal)
    ;
        ask('lay eggs', LayEggs),
        (LayEggs == yes ->
            identify_egg_layer(Animal)
        ;
            Animal = 'unknown animal'
        )
    ),
    
    write('I think the animal is: '), write(Animal), nl.

% Mammal identification
identify_mammal(Animal) :-
    ask('make a characteristic sound', MakesSound),
    (MakesSound == yes ->
        ask_multiple('sound does it make', '[bark, meow, neigh]', Sound),
        (Sound == bark -> Animal = dog
        ; Sound == meow -> Animal = cat  
        ; Sound == neigh -> Animal = horse
        ; Animal = 'unknown mammal')
    ;
        ask('is it large', IsLarge),
        (IsLarge == yes -> Animal = horse ; Animal = rabbit)
    ).

% Egg-laying animal identification
identify_egg_layer(Animal) :-
    ask('fly', CanFly),
    (CanFly == yes ->
        ask('is it large', IsLarge),
        (IsLarge == yes -> Animal = eagle ; Animal = chicken)
    ;
        ask('swim', CanSwim),
        (CanSwim == yes -> 
            ask('live on both land and water', Amphibious),
            (Amphibious == yes -> Animal = turtle ; Animal = duck)
        ;
            ask('is it very large', VeryLarge),
            (VeryLarge == yes -> Animal = ostrich ; Animal = penguin)
        )
    ).

% ====================================
% STEP 5: SYSTEM EXTENSIONS
% ====================================

% Find all possible animals matching certain criteria
possible_animals(List) :- 
    findall(Animal, matches_criteria(Animal), List).

% Check if an animal matches specific criteria
matches_criteria(Animal) :-
    (has_fur(Animal) ; lays_eggs(Animal)).

% Show all properties of an animal
show_properties(Animal) :-
    write('Properties of '), write(Animal), write(':'), nl,
    (has_fur(Animal) -> write('- Has fur'), nl ; true),
    (lays_eggs(Animal) -> write('- Lays eggs'), nl ; true),
    (flies(Animal) -> write('- Can fly'), nl ; true),
    (swims(Animal) -> write('- Can swim'), nl ; true),
    (is_domesticated(Animal) -> write('- Is domesticated'), nl ; true),
    (is_large(Animal) -> write('- Is large'), nl ; true),
    (is_carnivore(Animal) -> write('- Is carnivore'), nl ; true).

% Ambiguity handling - multiple possible answers
suggest_multiple(Suggestions) :-
    write('Based on the answers, it could be:'), nl,
    print_suggestions(Suggestions).

print_suggestions([]).
print_suggestions([H|T]) :-
    write('- '), write(H), nl,
    print_suggestions(T).

% ====================================
% HIERARCHICAL CLASSIFICATION (CHALLENGE)
% ====================================

% Classification tree: vertebrate -> mammal -> carnivore -> dog
ancestor(vertebrate, mammal).
ancestor(vertebrate, bird).
ancestor(mammal, carnivore).
ancestor(mammal, herbivore).
ancestor(carnivore, dog).
ancestor(carnivore, cat).

% Recursive rule for ancestors
is_ancestor(X, Y) :- ancestor(X, Y).
is_ancestor(X, Z) :- ancestor(X, Y), is_ancestor(Y, Z).

% Classify in hierarchy
classify_hierarchical(Animal, Categories) :-
    findall(Category, is_ancestor(Category, Animal), Categories).

% ====================================
% UTILITY AND TESTING PREDICATES
% ====================================

% Start the system
start :-
    identify_animal(_).

% List all known animals
list_animals :-
    write('Animals in the knowledge base:'), nl,
    findall(X, (has_fur(X) ; lays_eggs(X)), Animals),
    sort(Animals, SortedAnimals),
    print_list(SortedAnimals).

print_list([]).
print_list([H|T]) :-
    write('- '), write(H), nl,
    print_list(T).

% System tests
test_system :-
    write('=== SYSTEM TESTS ==='), nl,
    write('Mammals:'), nl,
    forall(is_mammal(X), (write('- '), write(X), nl)),
    write('Birds:'), nl,
    forall(is_bird(X), (write('- '), write(X), nl)),
    write('Animals that fly:'), nl,
    forall(can_fly(X), (write('- '), write(X), nl)).

% Enhanced identification with multiple possibilities
identify_with_alternatives(PossibleAnimals) :-
    write('=== ENHANCED ANIMAL IDENTIFICATION ==='), nl,
    ask('have fur', HasFur),
    ask('lay eggs', LaysEggs),
    ask('fly', Flies),
    ask('swim', Swims),
    
    findall(Animal, 
        (   (HasFur == yes -> has_fur(Animal) ; true),
            (LaysEggs == yes -> lays_eggs(Animal) ; true),
            (Flies == yes -> flies(Animal) ; true),
            (Swims == yes -> swims(Animal) ; true)
        ), 
        PossibleAnimals),
    
    (PossibleAnimals == [] ->
        write('No animals match your criteria.'), nl
    ; length(PossibleAnimals, 1) ->
        PossibleAnimals = [Animal],
        write('The animal is: '), write(Animal), nl
    ;
        write('Possible animals: '), nl,
        print_suggestions(PossibleAnimals)
    ).
