#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
NETWORK_NAME="privatenet"
SUBNET_NAME="privatenet-us"
REGION="us-central1"  # Change this to your preferred region

# Enable Private Google Access on the subnet
echo "Enabling Private Google Access on subnet: $SUBNET_NAME in $REGION..."
gcloud compute networks subnets update $SUBNET_NAME \
    --region=$REGION \
    --enable-private-ip-google-access

echo "Private Google Access enabled successfully!"
