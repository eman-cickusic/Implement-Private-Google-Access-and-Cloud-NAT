#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
NETWORK_NAME="privatenet"
FIREWALL_NAME="privatenet-allow-ssh"
IAP_RANGE="35.235.240.0/20"  # IAP IP range

# Create firewall rule for SSH access via IAP
echo "Creating firewall rule: $FIREWALL_NAME..."
gcloud compute firewall-rules create $FIREWALL_NAME \
    --network=$NETWORK_NAME \
    --allow=tcp:22 \
    --source-ranges=$IAP_RANGE \
    --description="Allow SSH access via IAP"

echo "Firewall rule created successfully!"
