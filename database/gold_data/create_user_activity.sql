CREATE OR REPLACE TABLE `netflix-pipeline-491410.gold_data.user_activity`
(
  userId INT64 OPTIONS(description="Unique identifier for the user."),
  totalRatings INT64 OPTIONS(description="Total of ratings provided by the user."),
  distinctMoviesRated INT64 OPTIONS(description="Quantity of unique movies the user has interacted with."),
  avgRating FLOAT64 OPTIONS(description="Average score given by the user."),
  stdRating FLOAT64 OPTIONS(description="Standard deviation of the user's ratings (measures consistency)."),
  firstActivityTimestamp TIMESTAMP OPTIONS(description="The earliest recorded interaction for this user."),
  lastActivityTimestamp TIMESTAMP OPTIONS(description="The most recent recorded interaction for this user.")
)
PARTITION BY DATE(lastActivityTimestamp)
CLUSTER BY userId
AS (
  SELECT
    userId,
    COUNT(*) AS totalRatings,
    COUNT(DISTINCT movieId) AS distinctMoviesRated,
    ROUND(AVG(rating), 2) AS avgRating,
    STDDEV(rating) AS stdRating,
    MIN(ratedAt) AS firstActivityTimestamp,
    MAX(ratedAt) AS lastActivityTimestamp,
  FROM `netflix-pipeline-491410.silver_data.fact_ratings`
  WHERE rating IS NOT NULL
  GROUP BY 1
);
