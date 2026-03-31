CREATE OR REPLACE TABLE `netflix-pipeline-491410.gold_data.genre_performance`
(
  genre STRING OPTIONS(description="Movie category (e.g., Adventure, Children, Fantasy)."),
  totalRatings INT64 OPTIONS(description="Total of ratings provided by the user."),
  avgRating FLOAT64 OPTIONS(description="Average score given by the user."),
  stdRating FLOAT64 OPTIONS(description="Standard deviation of the user's ratings (measures consistency)."),
  processedAt TIMESTAMP OPTIONS(description="Timestamp of when the record was processed.")
)
PARTITION BY DATE(processedAt)
CLUSTER BY genre
AS (
  SELECT
    TRIM(genre) AS genre,
    COUNT(*) AS totalRatings,
    ROUND(AVG(r.rating), 2) AS avgRating,
    STDDEV(r.rating) AS stdRating,
    TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 3 HOUR) AS processedAt
  FROM `netflix-pipeline-491410.silver_data.fact_ratings` r
  JOIN `netflix-pipeline-491410.silver_data.dim_movies` m
    ON m.movieId = r.movieId
  CROSS JOIN UNNEST(SPLIT(COALESCE(m.genres, ''), '|')) AS genre
  WHERE genre IS NOT NULL AND genre NOT IN ('', '(no genres listed)')
  GROUP BY 1
);
