CREATE OR REPLACE EXTERNAL TABLE `netflix-pipeline-491410.bronze_data.raw_user_recommendation_history` 
(
  userId STRING OPTIONS(description="Unique identifier for the user to whom the recommendation was made."),
  tstamp STRING OPTIONS(description="The timestamp when the recommendation was generated or recorded."),
  movieId STRING OPTIONS(description="Unique identifier for the recommended movie."),
  predictedRating STRING OPTIONS(description="The model-generated score predicting user preference (e.g., 1.0 - 5.0).")
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://netflix-data-pipeline/bronze/user_recommendation_history.csv'],
  skip_leading_rows = 1,
  allow_quoted_newlines = TRUE,
  allow_jagged_rows = TRUE
);
