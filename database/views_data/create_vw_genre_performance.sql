CREATE OR REPLACE VIEW `netflix-pipeline-491410.views_data.vw_genre_performance`
(
  genre OPTIONS(description="Movie category (e.g., Adventure, Children, Fantasy)."),
  totalRatings OPTIONS(description="Total of ratings provided by the user."),
  avgRating OPTIONS(description="Average score given by the user."),
  stdRating OPTIONS(description="Standard deviation of the user's ratings (measures consistency).")
)
AS (
  SELECT
    genre,
    totalRatings,
    avgRating,
    stdRating
  FROM `netflix-pipeline-491410.gold_data.genre_performance`
  ORDER BY totalRatings DESC, avgRating DESC
);
