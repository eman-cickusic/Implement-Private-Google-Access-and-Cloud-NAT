# Step 2: Enable Private Google Access

VM instances that have no external IP addresses can use Private Google Access to reach external IP addresses of Google APIs and services. By default, Private Google Access is disabled on a VPC network.

## Create a Cloud Storage Bucket

First, let's create a Cloud Storage bucket to test access to Google APIs and services:

1. In the Google Cloud console, navigate to **Cloud Storage > Buckets**
2. Click **Create**
3. Specify the following settings:
   - Name: Enter a globally unique name
   - Location type: **Multi-region**
4. Click **Create**
5. If prompted to enable public access prevention, ensure it is checked and click **Confirm**
6. Note the name of your storage bucket

## Copy an Image File into Your Bucket

Now, let's copy an image from a public Cloud Storage bucket to your own bucket:

1. In Cloud Shell, store the name of your bucket in an environment variable:
   ```bash
   export MY_BUCKET=[enter your bucket name here]
   ```

2. Verify the environment variable:
   ```bash
   echo $MY_BUCKET
   ```

3. Copy an image from a public Cloud Storage bucket to your own bucket:
   ```bash
   gcloud storage cp gs://cloud-training/gcpnet/private/access.svg gs://$MY_BUCKET
   ```

4. In the Cloud console, click your bucket name to verify that the image was copied

## Access the Image from Your VM Instance

Let's try to access the image from both Cloud Shell and the VM instance:

1. In Cloud Shell, try to copy the image from your bucket:
   ```bash
   gcloud storage cp gs://$MY_BUCKET/*.svg .
   ```
   This should work because Cloud Shell has an external IP address!

2. Connect to vm-internal:
   ```bash
   gcloud compute ssh vm-internal --zone YOUR_ZONE --tunnel-through-iap
   ```

3. Store the name of your bucket in an environment variable:
   ```bash
   export MY_BUCKET=[enter your bucket name here]
   ```

4. Verify the environment variable:
   ```bash
   echo $MY_BUCKET
   ```

5. Try to copy the image to vm-internal:
   ```bash
   gcloud storage cp gs://$MY_BUCKET/*.svg .
   ```
   This should not work because Private Google Access is disabled (by default)

6. Press Ctrl+Z to stop the request

## Enable Private Google Access

Private Google Access is enabled at the subnet level. When it is enabled, instances in the subnet that only have private IP addresses can send traffic to Google APIs and services through the default route (0.0.0.0/0) with a next hop to the default internet gateway.

1. In the Cloud console, navigate to **VPC network > VPC networks**
2. Click **privatenet** to open the network
3. Click **Subnets**, and then click **privatenet-us**
4. Click **Edit**
5. For Private Google access, select **On**
6. Click **Save**

> **Note**: Enabling Private Google Access is as simple as selecting **On** within the subnet!

## Test Access to Google APIs

Now let's test if the VM instance can access Google APIs and services:

1. In Cloud Shell for vm-internal, try to copy the image to vm-internal:
   ```bash
   gcloud storage cp gs://$MY_BUCKET/*.svg .
   ```
   This should work because vm-internal's subnet has Private Google Access enabled!

2. Return to your Cloud Shell instance:
   ```bash
   exit
   ```

> **Note**: To view the eligible APIs and services that you can use with Private Google Access, see supported services in the Private access options for services Guide.

## Using the Script

You can also use the provided script to automate the Cloud Storage bucket creation and enabling Private Google Access:

```bash
./scripts/create_cloud_storage.sh
./scripts/enable_private_google_access.sh
```

## Next Steps

In the next step, we'll [Configure a Cloud NAT Gateway](step3_configure_cloud_nat.md) to allow the VM instance to access the internet for updates and patches.
