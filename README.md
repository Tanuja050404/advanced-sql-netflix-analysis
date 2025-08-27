# Netflix Movies and TV Shows Data Analysis using SQL

## 📌 Overview
This project focuses on **analyzing Netflix’s movies and TV shows dataset** using **SQL**.  
We aim to solve **15 real-world business problems** and uncover insights about **content distribution, ratings, regions, and audience preferences**.

---

## 🎯 Objectives
- Analyze the **distribution of movies vs TV shows**
- Identify **most common ratings**
- Explore **year-wise, country-wise, and genre-wise trends**
- Find insights into **directors, actors, and content durations**
- Solve **15 SQL-based business problems**

---

## 📂 Dataset
- **Source:** [Netflix Movies & TV Shows Dataset – Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows)
- **Total Records:** ~8,800
- **Key Columns:**  
  `show_id`, `type`, `title`, `director`, `casts`, `country`,  
  `date_added`, `release_year`, `rating`, `duration`,  
  `listed_in`, `description`

---

## 🛠️ Database Schema
```sql
CREATE TABLE netflix (
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

