# Step 4: Configure and View Logs with Cloud NAT Logging

Cloud NAT logging allows you to log NAT connections and errors. When Cloud NAT logging is enabled, log entries can be generated for the following scenarios:

- When a network connection using NAT is created
- When a packet is dropped because no port was available for NAT

You can opt to log both kinds of events, or just one or the other. Created logs are sent to Cloud Logging.

## Enable NAT Logging

If logging is enabled, all collected logs are sent to Cloud Logging by default. You can filter these so that only certain logs are sent.

Follow these steps to enable logging for an existing NAT gateway:

1. In the Google Cloud console, navigate to **Network services > Cloud NAT**
2. Click on the **nat-config** gateway and then click **Edit**
3. Click the **Advanced configurations** dropdown to open that section
4. For Logging, select **Translation and errors**
5. Click **Save**

## View NAT Logs in Cloud Logging

Now that you have set up Cloud NAT logging for the nat-config gateway, let's find out where we can view our logs:

1. Click on **nat-config** to expose its details
2. Click on **View in Logs Explorer**
3. A new tab will open with Logs Explorer
4. You may not see any logs yet—that's because we just enabled this feature for the gateway

## Generate Logs

As a reminder, Cloud NAT logs are generated for the following sequences:

- When a network connection using NAT is created
- When a packet is dropped because no port was available for NAT

Let's connect to the VM instance again to generate some logs:

1. In Cloud Shell, connect to vm-internal:
   ```bash
   gcloud compute ssh vm-internal --zone YOUR_ZONE --tunnel-through-iap
   ```

2. Try to re-synchronize the package index of vm-internal:
   ```bash
   sudo apt-get update
   ```
   The output should indicate a successful update.

3. Return to your Cloud Shell instance:
   ```bash
   exit
   ```

4. Go back to the Logs Explorer tab and refresh the page
5. You should now see some logs related to the NAT connections

## Understanding NAT Logging

Cloud NAT logging provides several benefits:

1. **Troubleshooting**: You can use the logs to troubleshoot connectivity issues between your private instances and external services.

2. **Monitoring**: You can monitor the number of connections being established through the NAT gateway.

3. **Security**: You can detect unusual traffic patterns that might indicate security issues.

4. **Capacity planning**: You can use the logs to determine if you need to adjust your NAT configuration to handle more connections.

## Common Log Analysis Scenarios

Here are some common scenarios where NAT logging can be useful:

1. **Connectivity issues**: If your VM instances are having trouble connecting to external services, check the logs for dropped packets.

2. **Port exhaustion**: If you see a high number of dropped packets due to port exhaustion, you might need to allocate more NAT IP addresses or adjust your port allocation.

3. **Traffic patterns**: Analyze the logs to understand the traffic patterns of your VM instances and optimize your NAT configuration accordingly.

## Using the Script

You can also use the provided script to automate the NAT logging configuration:

```bash
./scripts/configure_nat_logging.sh
```

## Next Steps

Congratulations! You have successfully:

- Created a VM instance without an external IP address
- Connected to the VM instance using an IAP tunnel
- Enabled Private Google Access on a subnet
- Configured a Cloud NAT gateway
- Verified access to public IP addresses of Google APIs and services
- Configured and viewed logs with Cloud NAT Logging

These skills will help you build more secure and efficient cloud architectures in Google Cloud Platform.

## Additional Resources

- [Cloud NAT Documentation](https://cloud.google.com/nat/docs/overview)
- [Private Google Access Documentation](https://cloud.google.com/vpc/docs/private-google-access)
- [Identity-Aware Proxy Documentation](https://cloud.google.com/iap/docs)
