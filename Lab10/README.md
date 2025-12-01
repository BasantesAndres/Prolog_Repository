# 🧠 Prolog Semantic DCGs — Lab 10 (From Sentences to Meaning)

**Andrés Basantes**  
**Mathematical & Computational Logic**  
**Professor Pineda**

---

## 📌 Overview

This lab implements a **semantic grammar** in Prolog using **Definite Clause Grammars (DCGs)**.  
Instead of only checking if a sentence is grammatically correct, the DCG also builds a  
**logical meaning representation** as a Prolog term.

Examples:

- `the cat eats fish` ➜ `eat(cat, fish)`  
- `a dog sees the bird` ➜ `see(dog, bird)`

The project also extends the grammar to accept **adjectives** in noun phrases.

---

## 🎯 Lab Goals

By the end of this lab, the DCG should:

1. Recognize simple English sentences of the form:

   > Determiner + (0 or more adjectives) + Noun + Verb + Determiner + (0 or more adjectives) + Noun

2. Construct a **semantic term** for each sentence, such as:

   ```prolog
   eat(cat, fish).
   see(dog, bird).
   ```

3. Support **adjectives** before nouns in noun phrases, e.g.:

   - `the angry cat`
   - `a big hungry dog`
   - `the small bird`

4. Decide how to treat adjectives **semantically**  
   (in this implementation, they are processed syntactically but **ignored in the final term**).

---

## 🧩 Semantic Design

### 🧱 Core Idea

We use DCGs with **arguments** to carry semantic information:

```prolog
sentence(Sem) -->
    noun_phrase(Subj),
    verb_phrase(Subj, Sem).
```

- `Subj` = subject of the sentence (e.g. `cat`, `dog`)  
- `Sem`  = full semantic term (e.g. `eat(cat, fish)`)

The **verb phrase** builds the final meaning with the **univ operator** `=..`:

```prolog
verb_phrase(Subj, Sem) -->
    verb(V),
    noun_phrase(Obj),
    { Sem =.. [V, Subj, Obj] }.
```

If:

- `V   = eat`
- `Subj = cat`
- `Obj  = fish`

then:

```prolog
Sem = eat(cat, fish).
```

### 📚 Lexicon with Semantics

Nouns:

```prolog
noun(cat)  --> [cat].
noun(dog)  --> [dog].
noun(fish) --> [fish].
noun(bird) --> [bird].
```

Verbs:

```prolog
verb(eat) --> [eats].
verb(see) --> [sees].
```

Determiners:

```prolog
determiner --> [the].
determiner --> [a].
```

---

## 🌈 Adjectives (Task B)

The lab requires adding **adjectives in noun phrases**.

We define a list of modifiers:

```prolog
adjectives([]) --> [].
adjectives([M | Ms]) -->
    adjective(M),
    adjectives(Ms).
```

Concrete adjectives:

```prolog
adjective(big)    --> [big].
adjective(small)  --> [small].
adjective(angry)  --> [angry].
adjective(hungry) --> [hungry].
```

And we plug them into the noun phrase:

```prolog
noun_phrase(Subj) -->
    determiner,
    adjectives(_Mods),  % adjectives are syntactically handled
    noun(Subj).
```

### 🎭 Semantic Choice

The lab allows two options:

1. **Include adjectives in the meaning**, e.g. `entity(cat, [angry])`.  
2. **Ignore adjectives in the final term** but still parse them syntactically.

👉 In this implementation we choose **option 2** so that the semantic result remains:

- `eat(cat, fish)`  
- `see(dog, bird)`

even when adjectives are present, like:

- `the angry cat eats fish` ➜ `eat(cat, fish)`  
- `a big hungry dog sees the small bird` ➜ `see(dog, bird)`

---

## 📂 Project Structure

```text
/Lab10_Semantic_DCGs/
│── README.md               ← this file
│── Semantic-DCGsLab10.pl     ← Prolog DCG with semantics (Tasks A & B)
└── ScreenLab10.JPG         ← Screen querys
└── transcript.txt          ← sample Prolog session (queries + answers)
```

---

## ▶️ How to Run the Lab

### 1️⃣ Start SWI‑Prolog

In the project folder:

```bash
swipl
```

or:

```bash
swipl Semantic-DCGsLab10,pl
```

### 2️⃣ Load the File

If you launched `swipl` without a file:

```prolog
?- [dcg_semantic_lab].
true.
```

---

## 🧪 Main Queries (Required by the Lab)

### ✅ Basic Sentences (Task A)

```prolog
?- phrase(sentence(S), [the, cat, eats, fish]).
S = eat(cat, fish).

?- phrase(sentence(S), [a, dog, sees, the, bird]).
S = see(dog, bird).
```

These are the **core test cases** from the lab specification.

---

### ✨ Sentences with Adjectives (Task B)

```prolog
?- phrase(sentence(S), [the, angry, cat, eats, fish]).
S = eat(cat, fish).

?- phrase(sentence(S), [a, big, hungry, dog, sees, the, small, bird]).
S = see(dog, bird).

?- phrase(sentence(S), [the, small, bird, sees, a, fish]).
S = see(bird, fish).
```

