%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LAB 09 – Mini English Grammar with DCGs
%% Andres Basantes
%% Professor: Pineda
%%  - Short English Grammar using DCG
%%  - Supports:
%% Simple sentences: sentence --> noun_phrase, verb_phrase
%% Noun phrases with determiner, adjectives (optional), and noun
%% Verb phrases with verb and noun phrase
%% Parsing and generating sentences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% First rules
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% sentence: normal phrase + verbal phrase
sentence --> noun_phrase, verb_phrase.

%% nominal phrase:
%%  - determinant + (0,1 or more adjectives) + sustantive
noun_phrase --> determiner, adjectives, noun.

%% verbal phrase:
%%  - verb + nominal phrase
verb_phrase --> verb, noun_phrase.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. Lexicon 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Determinants
determiner --> [the].
determiner --> [a].

%% Sustantives
noun --> [cat].
noun --> [dog].
noun --> [fish].
noun --> [bird].

%% Verbs
verb --> [eats].
verb --> [sees].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. adjectives
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% one adjective
adjective --> [big].
adjective --> [small].
adjective --> [angry].


%% 0 adjectives or more:
%%  - base: none (empty list)
adjectives --> [].
%%  - a adjective following more adjectives
adjectives --> adjective, adjectives.
