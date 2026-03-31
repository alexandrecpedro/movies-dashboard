CREATE OR REPLACE VIEW `netflix-pipeline-491410.views_data.vw_top_movies`
(
  movieId OPTIONS(description="Unique identifier for the movie."),
  title OPTIONS(description="The full display title of the movie, without the release year."),
  genres OPTIONS(description="Pipe-separated list of movie categories (e.g., Adventure|Children|Fantasy)."),
  releaseYear OPTIONS(description="Release year extracted from the title (YYYY)."),
  totalRatings OPTIONS(description="Total of ratings provided by the user."),
  avgRating OPTIONS(description="Average score given by the user.")
)
AS (
  SELECT
    movieId,
    title,
    genres,
    releaseYear,
    totalRatings,
    avgRating
  FROM `netflix-pipeline-491410.gold_data.top_movies`
  ORDER BY avgRating DESC, totalRatings DESC
  LIMIT 10
);
