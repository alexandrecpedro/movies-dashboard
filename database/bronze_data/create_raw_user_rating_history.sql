CREATE OR REPLACE EXTERNAL TABLE `netflix-pipeline-491410.bronze_data.raw_user_rating_history` 
(
  userId STRING OPTIONS(description="Unique identifier for the user who provided the rating."),
  movieId STRING OPTIONS(description="Unique identifier for the movie being rated."),
  rating STRING OPTIONS(description="The numerical score assigned to the movie (e.g., 1-5 stars)."),
  tstamp STRING OPTIONS(description="The timestamp when the rating was recorded.")
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://netflix-data-pipeline/bronze/user_rating_history.csv'],
  skip_leading_rows = 1,
  allow_quoted_newlines = TRUE,
  allow_jagged_rows = TRUE
);
