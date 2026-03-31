CREATE OR REPLACE TABLE `netflix-pipeline-491410.gold_data.top_movies`
(
  movieId INT64 OPTIONS(description="Unique identifier for the movie."),
  title STRING OPTIONS(description="The full display title of the movie, without the release year."),
  genres STRING OPTIONS(description="Pipe-separated list of movie categories (e.g., Adventure|Children|Fantasy)."),
  releaseYear INT64 OPTIONS(description="Release year extracted from the title (YYYY)."),
  totalRatings INT64 OPTIONS(description="Total of ratings provided by the user."),
  avgRating FLOAT64 OPTIONS(description="Average score given by the user."),
  processedAt TIMESTAMP OPTIONS(description="Timestamp of when the record was processed.")
)
PARTITION BY DATE(processedAt)
CLUSTER BY movieId, title, genres
AS (
  -- WITH movie_kpis AS (
  --   SELECT
  --     r.movieId,
  --     m.title,
  --     m.genres,
  --     m.releaseYear,
  --     COUNT(*) AS totalRatings,
      -- ROUND(AVG(r.rating), 2) AS avgRating,
      -- TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 3 HOUR) AS processedAt
  --   FROM `netflix-pipeline-491410.silver_data.fact_ratings` r
  --   LEFT JOIN `netflix-pipeline-491410.silver_data.dim_movies` m
  --     ON m.movieId = r.movieId
  --   GROUP BY 1, 2, 3, 4
  -- )
  -- SELECT
  --   movieId,
  --   title,
  --   genres,
  --   releaseYear,
  --   totalRatings,
  --   avgRating
  -- FROM movie_kpis
  -- WHERE totalRatings >= 20 
  --   AND avgRating BETWEEN 0 AND 5
  -- -- ORDER BY avgRating DESC, totalRatings DESC
  -- LIMIT 10

  SELECT
    r.movieId,
    m.title,
    m.genres,
    m.releaseYear,
    COUNT(*) AS totalRatings,
    ROUND(AVG(r.rating), 2) AS avgRating,
    TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 3 HOUR) AS processedAt
  FROM `netflix-pipeline-491410.silver_data.fact_ratings` r
  LEFT JOIN `netflix-pipeline-491410.silver_data.dim_movies` m
    ON m.movieId = r.movieId
  GROUP BY 1, 2, 3, 4
  HAVING totalRatings >= 20 
    AND avgRating BETWEEN 0 AND 5
  LIMIT 10
);
