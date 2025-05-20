# Step 3: Configure a Cloud NAT Gateway

Although our VM instance can now access certain Google APIs and services without an external IP address, it cannot access the internet for updates and patches. In this step, we'll configure a Cloud NAT gateway, which allows the VM instance to reach the internet.

## Try to Update the VM Instance

Let's first check if our VM instances can access the internet for updates:

1. In Cloud Shell, try to re-synchronize the package index:
   ```bash
   sudo apt-get update
   ```
   This should work because Cloud Shell has an external IP address!

2. Connect to vm-internal:
   ```bash
   gcloud compute ssh vm-internal --zone YOUR_ZONE --tunnel-through-iap
   ```

3. Try to re-synchronize the package index of vm-internal:
   ```bash
   sudo apt-get update
   ```
   This should only work for Google Cloud packages because vm-internal only has access to Google APIs and services!

4. Press Ctrl+C to stop the request

## Configure a Cloud NAT Gateway

Cloud NAT is a regional resource. You can configure it to allow traffic from all ranges of all subnets in a region, from specific subnets in the region only, or from specific primary and secondary CIDR ranges only.

1. In the Google Cloud console, search for "Network services" in the search bar and select **Network services**
2. Click **Pin** next to Network services
3. Click **Cloud NAT**
4. Click **Get started** to configure a NAT gateway
5. Specify the following settings:
   - Gateway name: `nat-config`
   - Network: `privatenet`
   - Region: Your preferred region
6. For Cloud Router, select **Create new router**
7. For Name, enter `nat-router`
8. Click **Create**
9. Click **Create** to create the NAT gateway
10. Wait for the gateway's status to change to **Running**

> **Note**: The NAT mapping section allows you to choose the subnets to map to the NAT gateway. You can also manually assign static IP addresses that should be used when performing NAT.

## Verify the Cloud NAT Gateway

It may take up to 3 minutes for the NAT configuration to propagate to the VM, so wait at least a minute before trying to access the internet again.

1. In Cloud Shell for vm-internal, try to re-synchronize the package index:
   ```bash
   sudo apt-get update
   ```
   This should work because vm-internal is now using the NAT gateway!

2. Return to your Cloud Shell instance:
   ```bash
   exit
   ```

> **Note**: The Cloud NAT gateway implements outbound NAT, but not inbound NAT. In other words, hosts outside of your VPC network can only respond to connections initiated by your instances; they cannot initiate their own, new connections to your instances via NAT.

## Understanding Cloud NAT

Cloud NAT provides the following benefits:

1. **Improved security**: Instances without external IP addresses can still access the internet for updates, patches, and other necessary resources.

2. **Simplified architecture**: No need to deploy and manage proxy servers or bastion hosts.

3. **High availability**: As a managed service, Cloud NAT provides high availability without user management and intervention.

4. **Scalability**: Cloud NAT scales automatically based on the traffic volume.

## Using the Script

You can also use the provided script to automate the Cloud NAT gateway configuration:

```bash
./scripts/configure_cloud_nat.sh
```

## Next Steps

In the next step, we'll [Configure and View Logs with Cloud NAT Logging](step4_configure_nat_logging.md) to monitor NAT connections and errors.
