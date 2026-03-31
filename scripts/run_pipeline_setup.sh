#!/bin/bash
set -e

echo -e "Starting Movie Dashboard Pipeline..."

echo -e "Step 1/4: Setting Up Infrastructure..."
bash scripts/setup_infra.sh

echo -e "Step 2/4: Loading Bronze Layer (External Tables)..."
bash scripts/create_bronze_tables.sh

echo -e "Step 3/4: Executing Silver and Gold Transformations..."
bash scripts/create_silver_gold_transform.sh

echo -e "Step 4/4: Generating Views..."
bash scripts/create_views.sh

echo -e "Pipeline completed successfully!"
echo -e "Access Metabase at: http://localhost:3000"
