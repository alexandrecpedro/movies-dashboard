CREATE OR REPLACE EXTERNAL TABLE `netflix-pipeline-491410.bronze_data.raw_ratings_for_additional_users` 
(
  userId STRING OPTIONS(description="Unique identifier for the supplementary user providing the rating."),
  movieId STRING OPTIONS(description="Unique identifier for the movie being rated."),
  rating STRING OPTIONS(description="The actual score given by the user (typically on a scale of 0.5 - 5.0)."),
  tstamp STRING OPTIONS(description="The timestamp when the rating was recorded.")
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://netflix-data-pipeline/bronze/ratings_for_additional_users.csv'],
  skip_leading_rows = 1,
  allow_quoted_newlines = TRUE,
  allow_jagged_rows = TRUE
);
