# 🗺️ Prolog Map Coloring — Lab 07  
**Andrés Basantes**  
**Mathematical & Computational Logic**  
**Professor Pineda**

---

## 📌 Overview  
This project implements the **Map Coloring Problem** using **Prolog + CLP(FD)**.  
It includes the coloring of:

- 🇦🇺 **Australia**  
- 🌎 **South America**

The goal is to assign colors to each region such that **no two adjacent regions share the same color**.

---

## 📂 Project Structure  

```
/Lab07_MapColoring/
│── README.md              ← this file
│── lab07_map_coloring.pl  ← Prolog implementation
└── screenshots/           ← terminal outputs
    ├── australia_3colors.png
    ├── australia_4colors.png
    ├── sa_3colors.png
    └── sa_4colors.png
```

---

## ▶️ How to Run the Project

### 1️⃣ Open SWI-Prolog  
Windows:

```bash
swipl lab07_map_coloring.pl
```

---

## 🚀 Main Queries  

### 🇦🇺 Australia  
**Color Australia with 3 colors**
```prolog
?- pretty_color_au.
```

**Color Australia with 4 colors**
```prolog
?- pretty_color_au_4.
```

---

### 🌎 South America  
**Color South America with 3 colors**
```prolog
?- pretty_color_sa(3).
```

**Color South America with 4 colors**
```prolog
?- pretty_color_sa(4).
```

---

