# 🗺️ Prolog Map Coloring — Lab 08 (Minimum Colors)
**Andrés Basantes**  
**Mathematical & Computational Logic**  
**Professor Pineda**

---

## 📌 Overview  
This project extends the previous Map Coloring Lab by adding **optimization**:  
we compute the **minimum number of colors** required to legally color:

- 🇦🇺 **Australia**  
- 🌎 **South America**

using **Constraint Logic Programming (CLP(FD))** in Prolog.

---

## 🎯 Lab Objective  
Determine the *chromatic number* (minimum colors) of both maps by testing  
color counts incrementally using CLP(FD) constraints.

We implement a general solver that:
1. Tries K = 1, 2, 3, … up to MaxK  
2. Finds the first valid coloring  
3. Returns that K as the minimum number of colors

---

## 📂 Project Structure  

```
/Lab08_MapColoring_MinColors/
│── README.md                     ← this file
│── lab08_map_coloring_min_colors.pl   ← Prolog implementation
└── screenshots/                  
    ├── au_min_colors_raw.png
    ├── au_min_colors_pretty.png
    ├── sa_min_colors_raw.png
    └── sa_min_colors_pretty.png
```

---

## ▶️ How to Run the Project

### 1️⃣ Open SWI‑Prolog  
```bash
swipl lab08_map_coloring_min_colors.pl
```

---

## 🚀 Main Queries (Minimum Color Solver)

---

### 🇦🇺 Australia — Minimum Colors  
**Pretty printed result:**
```prolog
?- show_min_colors_au(4).
```

**Raw result:**
```prolog
?- min_colors_au(4, MinK, Vars).
```

---

### 🌎 South America — Minimum Colors  
**Pretty printed result:**
```prolog
?- show_min_colors_sa(6).
```

**Raw result:**
```prolog
?- min_colors_sa(6, MinK, Vars).
```

---

