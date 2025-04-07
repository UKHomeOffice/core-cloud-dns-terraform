# TF repo for Core Cloud DNS Config


# Route 53 Resolver Setup

This setup creates a **Route 53 profile**, **resolver endpoints** (inbound and outbound), and **shares the Route 53 profile** with the AWS **Organization** using AWS **Resource Access Manager (RAM)**.

## What This Configuration Does

- **Creates a Route 53 Resolver Profile**  
  Defines DNS behavior across your VPCs.

- **Deploys Inbound Resolver Endpoints**  
  Accepts DNS queries from on-premises networks or connected environments.

- **Deploys Outbound Resolver Endpoints**  
  Sends DNS queries to external services, including internal PDNS servers e.g POISE and public DNS servers.

- **Shares Route 53 Profile**  
  Shares the Route 53 Resolver profile across all accounts in your AWS Organization.

## Architecture Overview

- **Private Subnets**  
  Resolver endpoints are deployed inside private subnets for security.

- **Access to Internal PDNS**  
  Internal DNS servers are reachable via CTN.

- **Access to External DNS**  
  External DNS servers (e.g., NCSC PDNS, 8.8.8.8) are accessible via a NAT Gateway.

- **Security Groups**  
  Security groups are configured to allow UDP and TCP traffic on port 53 for DNS queries.

## Requirements

- AWS VPC with private subnets
- NAT Gateway for outbound DNS queries to public DNS servers
- Internal PDNS connectivity (CTN)
- AWS Organization setup
- IAM permissions for Route 53 Profile and AWS RAM

## Outputs

- Route 53  profile ARN
- Inbound and outbound resolver endpoint details
- Resource Share ARN for the Route 53 profile

```plaintext

+---------------------------+
|      AWS Organization     |
|  +---------------------+  |
|  |  Shared R53 Profile  |  |
|  +---------------------+  |
|            |              |
|     RAM Resource Share     |
|            |              |
|    +----------------+      |
|    |  Workload VPCs  |      |
|    +----------------+      |
+---------------------------+

