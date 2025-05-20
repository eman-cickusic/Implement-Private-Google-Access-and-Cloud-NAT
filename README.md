# Implement Private Google Access and Cloud NAT

This repository contains a step-by-step guide for implementing Private Google Access and Cloud NAT for VM instances without external IP addresses in Google Cloud Platform.

## Video

https://youtu.be/3YXHDGaLPqI

## Overview

In this project, I implemented Private Google Access and Cloud NAT for a VM instance that doesn't have an external IP address. Then, I verified access to public IP addresses of Google APIs and services and other connections to the internet.

VM instances without external IP addresses are isolated from external networks. Using Cloud NAT, these instances can access the internet for updates and patches, and in some cases, for bootstrapping. As a managed service, Cloud NAT provides high availability without user management and intervention.

## Objectives

- Configure a VM instance that doesn't have an external IP address
- Connect to a VM instance using an Identity-Aware Proxy (IAP) tunnel
- Enable Private Google Access on a subnet
- Configure a Cloud NAT gateway
- Verify access to public IP addresses of Google APIs and services and other connections to the internet

## Architecture

![Architecture Diagram](images/architecture.png)

## Project Structure

```
.
├── README.md
├── scripts/
│   ├── create_vpc_network.sh
│   ├── create_firewall_rule.sh
│   ├── create_vm_instance.sh
│   ├── create_cloud_storage.sh
│   ├── enable_private_google_access.sh
│   └── configure_cloud_nat.sh
├── images/
│   └── architecture.png
└── docs/
    ├── step1_create_vm_instance.md
    ├── step2_enable_private_google_access.md
    ├── step3_configure_cloud_nat.md
    └── step4_configure_nat_logging.md
```

## Steps

1. [Create a VM Instance](docs/step1_create_vm_instance.md)
2. [Enable Private Google Access](docs/step2_enable_private_google_access.md)
3. [Configure Cloud NAT Gateway](docs/step3_configure_cloud_nat.md)
4. [Configure and View Logs with Cloud NAT Logging](docs/step4_configure_nat_logging.md)

## Prerequisites

- Google Cloud Platform account
- Basic knowledge of networking concepts
- Familiarity with Google Cloud Console

## Getting Started

Clone this repository to get started:

```bash
git clone https://github.com/yourusername/private-google-access-cloud-nat.git
cd private-google-access-cloud-nat
```

Follow the detailed instructions in the documentation to implement Private Google Access and Cloud NAT.

## Key Concepts

### Private Google Access

Private Google Access enables VM instances without external IP addresses to reach Google APIs and services using internal IP addresses.

### Cloud NAT (Network Address Translation)

Cloud NAT is a distributed, software-defined managed service that lets VM instances without external IP addresses access the internet.

### Identity-Aware Proxy (IAP)

IAP enables access to VM instances via SSH without requiring the instances to have external IP addresses.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
