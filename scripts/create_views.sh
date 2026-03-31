#!/bin/bash

set -e
source .env

echo "Generating Views..."

bq query --use_legacy_sql=false < database/${VIEWS_DATASET}/create_vw_genre_performance.sql
bq query --use_legacy_sql=false < database/${VIEWS_DATASET}/create_vw_user_activity.sql
bq query --use_legacy_sql=false < database/${VIEWS_DATASET}/create_vw_top_movies.sql
bq query --use_legacy_sql=false < database/${VIEWS_DATASET}/create_vw_ratings_heatmap.sql
bq query --use_legacy_sql=false < database/${VIEWS_DATASET}/create_vw_scatter_popularity_vs_quality.sql
bq query --use_legacy_sql=false < database/${VIEWS_DATASET}/create_vw_movie_kpis.sql

echo "Views successfully generated!"
