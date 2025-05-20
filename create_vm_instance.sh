#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
VM_NAME="vm-internal"
NETWORK_NAME="privatenet"
SUBNET_NAME="privatenet-us"
ZONE="us-central1-a"  # Change this to your preferred zone
REGION="us-central1"  # Change this to your preferred region
MACHINE_TYPE="e2-medium"
IMAGE_FAMILY="debian-12"
IMAGE_PROJECT="debian-cloud"

# Create VM instance without external IP
echo "Creating VM instance: $VM_NAME in $ZONE..."
gcloud compute instances create $VM_NAME \
    --zone=$ZONE \
    --machine-type=$MACHINE_TYPE \
    --subnet=$SUBNET_NAME \
    --no-address \
    --image-family=$IMAGE_FAMILY \
    --image-project=$IMAGE_PROJECT \
    --boot-disk-size=10GB \
    --boot-disk-type=pd-standard

echo "VM instance created successfully!"
echo "Connect to the VM using: gcloud compute ssh $VM_NAME --zone=$ZONE --tunnel-through-iap"
