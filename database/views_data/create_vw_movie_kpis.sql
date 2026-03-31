CREATE OR REPLACE VIEW `netflix-pipeline-491410.views_data.vw_movie_kpi`
(
  movieId OPTIONS(description="Unique identifier for the movie."),
  title OPTIONS(description="The full display title of the movie, without the release year."),
  genres OPTIONS(description="Pipe-separated list of movie categories (e.g., Adventure|Children|Fantasy)."),
  releaseYear OPTIONS(description="Release year extracted from the title (YYYY)."),
  totalRatings OPTIONS(description="Total of ratings provided by the user."),
  avgRating OPTIONS(description="Average score given by the user."),
  stdRating OPTIONS(description="Standard deviation of the user's ratings (measures consistency)."),
  firstActivityTimestamp OPTIONS(description="The earliest recorded interaction for this user."),
  lastActivityTimestamp OPTIONS(description="The most recent recorded interaction for this user.")
)
AS (
  SELECT
    movieId,
    title,
    genres,
    releaseYear,
    totalRatings,
    avgRating,
    stdRating,
    firstActivityTimestamp,
    lastActivityTimestamp
  FROM `netflix-pipeline-491410.gold_data.movie_kpi`
);
