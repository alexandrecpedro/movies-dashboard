CREATE OR REPLACE EXTERNAL TABLE `netflix-pipeline-491410.bronze_data.raw_movies` 
(
  movieId STRING OPTIONS(description="Unique identifier for the movie."),
  title STRING OPTIONS(description="The full display title of the movie, often including the release year."),
  genres STRING OPTIONS(description="Pipe-separated list of movie categories (e.g., Adventure|Children|Fantasy).")
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://netflix-data-pipeline/bronze/movies.csv'],
  skip_leading_rows = 1,
  allow_quoted_newlines = TRUE,
  allow_jagged_rows = TRUE
);
