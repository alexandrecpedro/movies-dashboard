CREATE OR REPLACE TABLE `netflix-pipeline-491410.silver_data.dim_movies` 
(
  movieId INT64 OPTIONS(description="Unique identifier for the movie."),
  title STRING OPTIONS(description="The full display title of the movie, without the release year."),
  genres STRING OPTIONS(description="Pipe-separated list of movie categories (e.g., Adventure|Children|Fantasy)."),
  releaseYear INT64 OPTIONS(description="Release year extracted from the title (YYYY)."),
  processedAt TIMESTAMP OPTIONS(description="Timestamp of when the record was processed.")
)
PARTITION BY DATE(processedAt)
CLUSTER BY movieId, title, genres, releaseYear
AS (
  SELECT DISTINCT
    SAFE_CAST(movieId AS INT64) AS movieId,
    COALESCE(REGEXP_EXTRACT(title, r'^(.*)\s\(\d{4}\)$'), title) AS title,
    genres,
    SAFE_CAST(REGEXP_EXTRACT(title, r'\((\d{4})\)') AS INT64) AS releaseYear,
    TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 3 HOUR) AS processedAt
  FROM `netflix-pipeline-491410.bronze_data.raw_movies`
);
