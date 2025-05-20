# Step 1: Create the VM Instance

In this step, we'll create a VPC network with firewall rules and a VM instance that has no external IP address. Then we'll connect to the instance using an IAP tunnel.

## Create a VPC Network and Firewall Rules

First, we need to create a VPC network for the VM instance and a firewall rule to allow SSH access.

1. In the Google Cloud console, navigate to **VPC network > VPC networks**
2. Click **Create VPC Network**
3. For Name, enter `privatenet`
4. For Subnet creation mode, select **Custom**
5. In New Subnet, specify the following settings:
   - Name: `privatenet-us`
   - Region: Your preferred region
   - IPv4 address range: `10.130.0.0/20`
   - Do not enable Private Google access yet!
6. Click **Done**
7. Click **Create** and wait for the network to be created

Next, create a firewall rule:

1. In the left pane, click **Firewall**
2. Click **Create Firewall Rule**
3. Specify the following settings:
   - Name: `privatenet-allow-ssh`
   - Network: `privatenet`
   - Targets: **All instances in the network**
   - Source filter: **IPv4 ranges**
   - Source IPv4 ranges: `35.235.240.0/20` (IAP address range)
   - Protocols and ports: **Specified protocols and ports**
   - For TCP, select the checkbox and specify port `22`
4. Click **Create**

> **Note**: In order to connect to your private instance using SSH, you need to open an appropriate port on the firewall. IAP connections come from a specific set of IP addresses (35.235.240.0/20). Therefore, you can limit the rule to this CIDR range.

## Create the VM Instance with No Public IP Address

Now let's create a VM instance without an external IP address:

1. In the Google Cloud console, navigate to **Compute Engine > VM instances**
2. Click **Create Instance**
3. On the Machine configuration page, specify the following:
   - Name: `vm-internal`
   - Region: Your preferred region
   - Zone: Your preferred zone
   - Series: `E2`
   - Machine type: `e2-medium` (2vCPU, 1 core, 4 GB memory)
4. Click **OS and storage**
5. Select **Debian GNU/Linux 12 (bookworm)** as the operating system
6. Click **Networking**
7. In Network interfaces, edit the network interface by specifying:
   - Network: `privatenet`
   - Subnetwork: `privatenet-us`
   - External IPv4 address: **None**
8. Click **Done**
9. Click **Create**, and wait for the VM instance to be created
10. On the VM instances page, verify that the External IP of `vm-internal` is **None**

> **Note**: The default setting for a VM instance is to have an ephemeral external IP address. This behavior can be changed with a policy constraint at the organization or project level.

## SSH to vm-internal Using the IAP Tunnel

Now we'll connect to the VM instance using an Identity-Aware Proxy (IAP) tunnel:

1. Open Cloud Shell
2. Run the following command to set up authentication without opening a browser:
   ```bash
   gcloud auth login --no-launch-browser
   ```
3. Follow the prompts to authenticate
4. Connect to the VM instance using the following command:
   ```bash
   gcloud compute ssh vm-internal --zone YOUR_ZONE --tunnel-through-iap
   ```
5. Test the external connectivity of vm-internal:
   ```bash
   ping -c 2 www.google.com
   ```
   This should not work because vm-internal has no external IP address!

6. Return to Cloud Shell:
   ```bash
   exit
   ```

> **Note**: When instances do not have external IP addresses, they can only be reached by other instances on the network via a managed VPN gateway or via a Cloud IAP tunnel. Cloud IAP enables context-aware access to VMs via SSH and RDP without bastion hosts.

## Using the Script

You can also use the provided script to automate the VPC network, firewall rule, and VM instance creation:

```bash
./scripts/create_vpc_network.sh
./scripts/create_firewall_rule.sh
./scripts/create_vm_instance.sh
```

## Next Steps

In the next step, we'll [Enable Private Google Access](step2_enable_private_google_access.md) to allow the VM instance to access Google APIs and services.
