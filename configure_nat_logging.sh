#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
ROUTER_NAME="nat-router"
NAT_CONFIG="nat-config"
REGION="us-central1"  # Change this to your preferred region

# Enable logging for Cloud NAT gateway
echo "Enabling logging for Cloud NAT gateway: $NAT_CONFIG..."
gcloud compute routers nats update $NAT_CONFIG \
    --router=$ROUTER_NAME \
    --region=$REGION \
    --enable-logging

echo "NAT logging enabled successfully!"
echo "You can view the logs in Cloud Logging."
