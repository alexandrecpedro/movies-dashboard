CREATE OR REPLACE VIEW `netflix-pipeline-491410.views_data.vw_ratings_heatmap`
(
  year OPTIONS(description="Year when the rating was recorded."),
  month_number OPTIONS(description="The numerical month (1 to 12) when the rating was recorded."),
  month_name OPTIONS(description="The month name (e.g., Jan, Feb) when the rating was recorded."),
  totalRatings OPTIONS(description="Total of ratings provided by the user.")
)
AS (
  SELECT
    year,
    month_number,
    month_name,
    totalRatings
  FROM `netflix-pipeline-491410.gold_data.ratings_heatmap`
  ORDER BY 1, 2
);
