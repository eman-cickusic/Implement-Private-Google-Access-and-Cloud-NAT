#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
NETWORK_NAME="privatenet"
ROUTER_NAME="nat-router"
NAT_CONFIG="nat-config"
REGION="us-central1"  # Change this to your preferred region

# Create Cloud Router
echo "Creating Cloud Router: $ROUTER_NAME in $REGION..."
gcloud compute routers create $ROUTER_NAME \
    --network=$NETWORK_NAME \
    --region=$REGION

# Configure Cloud NAT gateway
echo "Configuring Cloud NAT gateway: $NAT_CONFIG..."
gcloud compute routers nats create $NAT_CONFIG \
    --router=$ROUTER_NAME \
    --region=$REGION \
    --nat-all-subnet-ip-ranges \
    --auto-allocate-nat-external-ips

echo "Cloud NAT gateway configured successfully!"
echo "It may take up to 3 minutes for the NAT configuration to propagate to VMs."
