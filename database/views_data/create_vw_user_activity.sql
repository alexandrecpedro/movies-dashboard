CREATE OR REPLACE VIEW `netflix-pipeline-491410.views_data.vw_user_activity`
(
  userId OPTIONS(description="Unique identifier for the user."),
  totalRatings OPTIONS(description="Total of ratings provided by the user."),
  distinctMoviesRated OPTIONS(description="Quantity of unique movies the user has interacted with."),
  avgRating OPTIONS(description="Average score given by the user."),
  stdRating OPTIONS(description="Standard deviation of the user's ratings (measures consistency)."),
  firstActivityTimestamp OPTIONS(description="The earliest recorded interaction for this user."),
  lastActivityTimestamp OPTIONS(description="The most recent recorded interaction for this user.")
)
AS (
  SELECT
    userId,
    totalRatings,
    distinctMoviesRated,
    avgRating,
    stdRating,
    firstActivityTimestamp,
    lastActivityTimestamp,
  FROM `netflix-pipeline-491410.gold_data.user_activity`
  ORDER BY totalRatings DESC, avgRating DESC
);
