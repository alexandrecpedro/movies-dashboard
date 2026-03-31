if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo "Error: .env file not found!"
    exit 1
fi

echo "Starting infrastructure setup for project: $GCP_PROJECT_ID"

# Set the active Google Cloud project
gcloud config set project $GCP_PROJECT_ID

# Create the Cloud Storage bucket
gsutil mb -l $GCP_REGION gs://$BUCKET_NAME || echo "Bucket already exists or an error occurred during creation."

# Create BigQuery Datasets for the Medallion Architecture (Bronze, Silver, Gold)
bq mk --location=$GCP_REGION $BRONZE_DATASET || echo "Bronze Dataset already exists."
bq mk --location=$GCP_REGION $SILVER_DATASET || echo "Silver Dataset already exists."
bq mk --location=$GCP_REGION $GOLD_DATASET || echo "Gold Dataset already exists."

echo "Basic infrastructure is ready!"
echo "Next step: Uploading CSV files to gs://$BUCKET_NAME/$FOLDER_NAME/"

# Multi-threaded copy of local CSV data to the GCS Bucket
gsutil -m cp data/*.csv gs://$BUCKET_NAME/$FOLDER_NAME/ || echo "Files already exist or an error occurred during upload."

echo "Starting Metabase via Docker..."
docker compose up -d
echo "Metabase is available at: http://localhost:3000"
