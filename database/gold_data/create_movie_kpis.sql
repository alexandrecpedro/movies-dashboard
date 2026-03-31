CREATE OR REPLACE TABLE `netflix-pipeline-491410.gold_data.movie_kpi`
(
  movieId INT64 OPTIONS(description="Unique identifier for the movie."),
  title STRING OPTIONS(description="The full display title of the movie, without the release year."),
  genres STRING OPTIONS(description="Pipe-separated list of movie categories (e.g., Adventure|Children|Fantasy)."),
  releaseYear INT64 OPTIONS(description="Release year extracted from the title (YYYY)."),
  totalRatings INT64 OPTIONS(description="Total of ratings provided by the user."),
  avgRating FLOAT64 OPTIONS(description="Average score given by the user."),
  stdRating FLOAT64 OPTIONS(description="Standard deviation of the user's ratings (measures consistency)."),
  firstActivityTimestamp TIMESTAMP OPTIONS(description="The earliest recorded interaction for this user."),
  lastActivityTimestamp TIMESTAMP OPTIONS(description="The most recent recorded interaction for this user.")
)
PARTITION BY DATE(lastActivityTimestamp)
CLUSTER BY movieId, title, genres
AS (
  SELECT
    r.movieId,
    m.title,
    m.genres,
    m.releaseYear,
    COUNT(*) AS totalRatings,
    ROUND(AVG(r.rating), 2) AS avgRating,
    STDDEV(r.rating) AS stdRating,
    MIN(r.ratedAt) AS firstActivityTimestamp,
    MAX(r.ratedAt) AS lastActivityTimestamp,
  FROM `netflix-pipeline-491410.silver_data.fact_ratings` r
  LEFT JOIN `netflix-pipeline-491410.silver_data.dim_movies` m
    ON m.movieId = r.movieId
  GROUP BY 1, 2, 3, 4
);
