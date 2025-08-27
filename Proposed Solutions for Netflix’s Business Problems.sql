-- Netflix Advanced SQL Data Analysis
-- Solving 15 Key Business Problems using PostgreSQL
-- Dataset: Netflix Titles

/* ---------------------------------------------------
   1. Compare the total count of Movies vs TV Shows
--------------------------------------------------- */
SELECT 
    type AS content_type,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY content_type
ORDER BY total_titles DESC;


/* ---------------------------------------------------
   2. Determine the most frequent rating for each content type
--------------------------------------------------- */
WITH rating_summary AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS total
    FROM netflix
    GROUP BY type, rating
),
ranked_ratings AS (
    SELECT 
        type,
        rating,
        total,
        ROW_NUMBER() OVER (PARTITION BY type ORDER BY total DESC) AS rn
    FROM rating_summary
)
SELECT 
    type,
    rating AS most_common_rating
FROM ranked_ratings
WHERE rn = 1;


/* ---------------------------------------------------
   3. Retrieve all movies released in a specific year (e.g., 2020)
--------------------------------------------------- */
SELECT 
    show_id,
    title,
    director,
    release_year,
    duration
FROM netflix
WHERE type = 'Movie'
  AND release_year = 2020;


/* ---------------------------------------------------
   4. Top 5 countries with the highest number of titles on Netflix
--------------------------------------------------- */
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country_name,
    COUNT(*) AS total_titles
FROM netflix
WHERE country IS NOT NULL
GROUP BY country_name
ORDER BY total_titles DESC
LIMIT 5;


/* ---------------------------------------------------
   5. Find the longest movie by duration
--------------------------------------------------- */
SELECT 
    title,
    duration
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC
LIMIT 1;


/* ---------------------------------------------------
   6. List all content added to Netflix in the last 5 years
--------------------------------------------------- */
SELECT 
    show_id,
    title,
    date_added
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= (CURRENT_DATE - INTERVAL '5 years')
ORDER BY date_added DESC;


/* ---------------------------------------------------
   7. Find all movies or shows directed by 'Rajiv Chilaka'
--------------------------------------------------- */
SELECT 
    show_id,
    title,
    director
FROM netflix,
     UNNEST(STRING_TO_ARRAY(director, ',')) AS dir
WHERE TRIM(dir) = 'Rajiv Chilaka';


/* ---------------------------------------------------
   8. List TV Shows with more than 5 seasons
--------------------------------------------------- */
SELECT 
    title,
    duration
FROM netflix
WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::INT > 5;


/* ---------------------------------------------------
   9. Count the number of titles in each genre category
--------------------------------------------------- */
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) AS genre,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY genre
ORDER BY total_titles DESC;


/* ---------------------------------------------------
   10. Top 5 years where India released the most content on Netflix
--------------------------------------------------- */
SELECT 
    release_year,
    COUNT(show_id) AS total_releases
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY release_year
ORDER BY total_releases DESC
LIMIT 5;


/* ---------------------------------------------------
   11. List all movies categorized under 'Documentaries'
--------------------------------------------------- */
SELECT 
    title,
    release_year,
    listed_in
FROM netflix
WHERE listed_in ILIKE '%Documentaries%';


/* ---------------------------------------------------
   12. Find all Netflix titles without a director assigned
--------------------------------------------------- */
SELECT 
    show_id,
    title,
    type
FROM netflix
WHERE director IS NULL;


/* ---------------------------------------------------
   13. Find all movies featuring 'Salman Khan' in the last 10 years
--------------------------------------------------- */
SELECT 
    title,
    release_year,
    casts
FROM netflix
WHERE casts ILIKE '%Salman Khan%'
  AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;


/* ---------------------------------------------------
   14. Top 10 actors with the highest number of appearances in Indian movies
--------------------------------------------------- */
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))) AS actor,
    COUNT(*) AS appearances
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY actor
ORDER BY appearances DESC
LIMIT 10;


/* ---------------------------------------------------
   15. Categorize content as 'Violent' or 'Safe' based on description
--------------------------------------------------- */
SELECT 
    category,
    type,
    COUNT(*) AS total_content
FROM (
    SELECT 
        *,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Violent'
            ELSE 'Safe'
        END AS category
    FROM netflix
) categorized
GROUP BY category, type
ORDER BY type, total_content DESC;

-- End of Netflix SQL Analysis Report


