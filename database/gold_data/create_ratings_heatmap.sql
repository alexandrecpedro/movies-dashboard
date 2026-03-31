CREATE OR REPLACE TABLE `netflix-pipeline-491410.gold_data.ratings_heatmap`
(
  year INT64 OPTIONS(description="Year when the rating was recorded."),
  month_number INT64 OPTIONS(description="The numerical month (1 to 12) when the rating was recorded."),
  month_name STRING OPTIONS(description="The month name (e.g., Jan, Feb) when the rating was recorded."),
  totalRatings INT64 OPTIONS(description="Total of ratings provided by the user."),
  processedAt TIMESTAMP OPTIONS(description="Timestamp of when the record was processed.")
)
PARTITION BY DATE(processedAt)
CLUSTER BY year, month_number, month_name
AS (
  SELECT
    EXTRACT(YEAR FROM ratedAt) AS year,
    EXTRACT(MONTH FROM ratedAt) AS month_number,
    FORMAT_TIMESTAMP('%b', ratedAt) AS month_name,
    COUNT(*) AS totalRatings,
    TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 3 HOUR) AS processedAt
  FROM `netflix-pipeline-491410.silver_data.fact_ratings`
  GROUP BY 1, 2, 3
);
