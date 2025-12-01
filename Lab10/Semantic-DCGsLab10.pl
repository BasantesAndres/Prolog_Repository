%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LAB 10 -  Semantic DCGs
%% Stiudent: Andrés Basantes
%% Based on Lab 07 (Australia & South America)
%% Professor: Pineda
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% This file implements:
%   - Task A: base semantic grammar
%   - Task B: extension with adjectives
%
% Semantic convention:
%   "the cat eats fish"  -->  eat(cat, fish)
%   "a dog sees the bird" --> see(dog, bird)
%
% Adjectives are handled syntactically but are
% ignored in the final semantic representation.
% ============================================

% ---------- Core semantic grammar (Task A) ----------

% sentence(-Sem)
% Sem is a Prolog term representing the meaning of the sentence.
sentence(Sem) -->
    noun_phrase(Subj),
    verb_phrase(Subj, Sem).

% noun_phrase(-Subj)
% A noun phrase: determiner + (zero or more adjectives) + noun.
% Semantically, we keep only the noun (Subj) as in the lab examples.
noun_phrase(Subj) -->
    determiner,
    adjectives(_Mods),    % Task B: adjectives before the noun (ignored in Sem)
    noun(Subj).

% verb_phrase(+Subj, -Sem)
% Builds Sem = V(Subj, Obj) using the =.. operator (univ).
verb_phrase(Subj, Sem) -->
    verb(V),
    noun_phrase(Obj),
    {
        Sem =.. [V, Subj, Obj]
    }.

% ---------- Lexicon with semantics (Task A) ----------

% Nouns: noun(-Entity)
noun(cat)  --> [cat].
noun(dog)  --> [dog].
noun(fish) --> [fish].
noun(bird) --> [bird].

% Verbs: verb(-Functor)
% Each verb corresponds to a binary functor (eat/2, see/2).
verb(eat) --> [eats].
verb(see) --> [sees].

% Determiners (no semantic argument here)
determiner --> [the].
determiner --> [a].

% ---------- Adjectives extension (Task B) ----------

% adjectives(-Mods)
% A list of modifiers (adjectives). We collect them in Mods but
% choose to ignore them in the final semantic term (as allowed by the lab).
% This still satisfies the syntactic requirement: adjectives before nouns.

% Zero adjectives
adjectives([]) --> [].

% One or more adjectives
adjectives([M | Ms]) -->
    adjective(M),
    adjectives(Ms).

% Concrete adjective words
adjective(big)    --> [big].
adjective(small)  --> [small].
adjective(angry)  --> [angry].
adjective(hungry) --> [hungry].


