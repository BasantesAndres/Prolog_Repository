# 🧠 Mini English Grammar with DCGs – Lab 09
**Andrés Basantes**  
**Mathematical & Computational Logic**  
**Professor Pineda**

---


The goal of the lab is to **parse** and **generate** simple English sentences like:

> `the cat eats fish`  
> `the big angry dog sees a small bird`

---

## 📚 What this lab does

- Implements a **mini grammar** for English sentences:
  - `sentence --> noun_phrase, verb_phrase.`
  - `noun_phrase --> determiner, adjectives, noun.`
  - `noun_phrase --> noun.      % bare noun (e.g. "fish")`
  - `verb_phrase --> verb, noun_phrase.`
- Uses a small **lexicon**:
  - Determiners: `the`, `a`
  - Nouns: `cat`, `dog`, `fish`, `bird`
  - Verbs: `eats`, `sees`
  - Adjectives: `big`, `small`, `angry`
- Supports:
  - ✅ **Parsing** (checking if a sentence is grammatically correct)
  - ✅ **Generation** (creating valid sentences from the grammar)

---

## 🏗️ Project Structure (Architecture)

```text
Lab09_Mini_English_Grammar/
├── README.md                 # This file 📄
├── mini_english_grammar.pl   # Prolog file with the DCG grammar 🧩
└── screens/                  # Screenshots of the program running 🖼️
    ├── parsing_true     # phrase(sentence, [the, cat, eats, fish]).
    ├── parsing_false    # phrase(sentence, [dog, the, eats]).
    ├── generation       # phrase(sentence, X).
    ├── generation       # phrase(sentence, X). (x) (x).
```



## ▶️ How to Run

1. Open a terminal / PowerShell in the project folder.
2. Start SWI-Prolog and load the file:

   ```prolog
   ?- [mini_english_grammar].
   ```



### ✅ Valid sentence

```prolog
?- phrase(sentence, [the, cat, eats, fish]).
true.
```

### ❌ Invalid sentence

```prolog
?- phrase(sentence, [dog, the, eats]).
false.
```


## 🧬 Generation Examples (Sentence Generation)

Generate sentences that are valid according to the grammar:

```prolog
?- phrase(sentence, X).
X = [the, cat, eats, fish] ;
X = [the, cat, eats, the, dog] ;
X = [a, big, dog, sees, the, bird] ;
...
```

Press `;` to see more solutions.  
You can also test with adjectives:

```prolog
?- phrase(sentence, [the, big, dog | Rest]).
Rest = [eats, fish] ;
Rest = [eats, the, cat] ;
Rest = [sees, a, small, bird] ;
...
```

