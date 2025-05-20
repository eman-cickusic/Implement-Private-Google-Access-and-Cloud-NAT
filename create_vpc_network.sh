#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
NETWORK_NAME="privatenet"
SUBNET_NAME="privatenet-us"
SUBNET_RANGE="10.130.0.0/20"
REGION="us-central1"  # Change this to your preferred region

# Create VPC network
echo "Creating VPC network: $NETWORK_NAME..."
gcloud compute networks create $NETWORK_NAME --subnet-mode=custom

# Create subnet
echo "Creating subnet: $SUBNET_NAME in $REGION with range $SUBNET_RANGE..."
gcloud compute networks subnets create $SUBNET_NAME \
    --network=$NETWORK_NAME \
    --region=$REGION \
    --range=$SUBNET_RANGE

echo "VPC network and subnet created successfully!"
