#!/bin/bash

set -e
source .env

echo "Starting data pipeline..."

echo "Silver Layer Transformations..."
bq query --use_legacy_sql=false < database/${SILVER_DATASET}/create_dim_movies.sql
bq query --use_legacy_sql=false < database/${SILVER_DATASET}/create_fact_ratings.sql

echo "Gold Layer Enrichment..."
bq query --use_legacy_sql=false < database/${GOLD_DATASET}/create_genre_performance.sql
bq query --use_legacy_sql=false < database/${GOLD_DATASET}/create_user_activity.sql
bq query --use_legacy_sql=false < database/${GOLD_DATASET}/create_top_movies.sql
bq query --use_legacy_sql=false < database/${GOLD_DATASET}/create_ratings_heatmap.sql
bq query --use_legacy_sql=false < database/${GOLD_DATASET}/create_scatter_popularity_vs_quality.sql
bq query --use_legacy_sql=false < database/${GOLD_DATASET}/create_movie_kpis.sql

echo "✅ All set!"
