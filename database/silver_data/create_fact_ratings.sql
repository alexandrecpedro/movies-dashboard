CREATE OR REPLACE TABLE `netflix-pipeline-491410.silver_data.fact_ratings` 
(
  userId INT64 OPTIONS(description="Unique identifier for the user."),
  movieId INT64 OPTIONS(description="Unique identifier for the movie."),
  rating FLOAT64 OPTIONS(description="The numerical score assigned to the movie (e.g., 1-5 stars)."),
  ratedAt TIMESTAMP OPTIONS(description="The timestamp when the rating was recorded."),
  src STRING OPTIONS(description="Data source."),
  processedAt TIMESTAMP OPTIONS(description="Timestamp of when the record was processed.")
)
PARTITION BY DATE(processedAt)
CLUSTER BY userId, movieId, src
AS (
  WITH all_ratings AS (
    SELECT 
      SAFE_CAST(NULLIF(userId, '') AS INT64) AS userId,
      SAFE_CAST(NULLIF(movieId, '') AS INT64) AS movieId,
      NULLIF(ROUND(SAFE_CAST(REPLACE(NULLIF(NULLIF(rating, 'NA'), ''), ',', '.') AS FLOAT64), 2), -1) AS rating,
      COALESCE(
        SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S%Ez', tstamp),
        SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', tstamp)
      ) AS ratedAt,
      'user_rating_history' AS src,
      TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 3 HOUR) AS processedAt
    FROM
      `netflix-pipeline-491410.bronze_data.raw_user_rating_history`

    UNION ALL
    
    SELECT 
      SAFE_CAST(NULLIF(userId, '') AS INT64) AS userId,
      SAFE_CAST(NULLIF(movieId, '') AS INT64) AS movieId,
      NULLIF(ROUND(SAFE_CAST(REPLACE(NULLIF(NULLIF(rating, 'NA'), ''), ',', '.') AS FLOAT64), 2), -1) AS rating,
      COALESCE(
        SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S%Ez', tstamp),
        SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', tstamp)
      ) AS ratedAt,
      'ratings_for_additional_users' AS src,
      TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 3 HOUR) AS processedAt
    FROM
      `netflix-pipeline-491410.bronze_data.raw_ratings_for_additional_users`
  )

  SELECT
    userId,
    movieId,
    rating,
    ratedAt,
    src,
    processedAt
  FROM all_ratings
  WHERE userId IS NOT NULL
    AND movieId IS NOT NULL
    AND rating IS NOT NULL
    AND ratedAt IS NOT NULL
);
