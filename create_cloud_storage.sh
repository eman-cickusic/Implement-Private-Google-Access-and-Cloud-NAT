#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Create a unique bucket name using the project ID and a timestamp
PROJECT_ID=$(gcloud config get-value project)
BUCKET_NAME="${PROJECT_ID}-bucket-$(date +%s)"

# Create Cloud Storage bucket
echo "Creating Cloud Storage bucket: $BUCKET_NAME..."
gcloud storage buckets create gs://$BUCKET_NAME --location=us

# Copy the sample image from public bucket
echo "Copying sample image to the bucket..."
gcloud storage cp gs://cloud-training/gcpnet/private/access.svg gs://$BUCKET_NAME/

echo "Cloud Storage bucket created successfully!"
echo "Bucket name: $BUCKET_NAME"
echo "To use this bucket in your scripts, run: export MY_BUCKET=$BUCKET_NAME"
