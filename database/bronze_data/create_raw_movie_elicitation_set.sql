CREATE OR REPLACE EXTERNAL TABLE `netflix-pipeline-491410.bronze_data.raw_movie_elicitation_set` 
(
  movieId STRING OPTIONS(description="Unique identifier for the movie being presented for elicitation."),
  month_idx STRING OPTIONS(description="The relative month number in the study (e.g., 0 = January, 1 = February)."),
  source STRING OPTIONS(description="The experimental group or algorithm version responsible for this elicitation."),
  tstamp STRING OPTIONS(description="The precise timestamp marking the start of the elicitation window for this movie.")
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://netflix-data-pipeline/bronze/movie_elicitation_set.csv'],
  skip_leading_rows = 1,
  allow_quoted_newlines = TRUE,
  allow_jagged_rows = TRUE
);
