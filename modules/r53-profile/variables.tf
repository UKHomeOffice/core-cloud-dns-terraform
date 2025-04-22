######
# Shared
######


variable "tags" {
  type        = map(string)
  description = "Tags to apply to AWS resources"
}

variable "vpc_id" {
  description = "VPC ID of the network account where the Route 53 profile will be associated"
  type        = string
}


variable "poise_domain_name" {
  description = "Poise Domain Name"
  type        = string
}

variable "poise_dns1_ip" {
  description = "Poise DNS1 IP"
  default     = "1.2.3.4"
  type        = string
}

variable "poise_dns2_ip" {
  description = "Poise DNS2 IP"
  default     = "4.5.6.7"
  type        = string
}

variable "ncsc_dns1_ip" {
  description = "NCSC DNS1 IP"
  default     = "1.2.3.4"
  type        = string
}

variable "ncsc_dns2_ip" {
  description = "NCSC DNS2 IP"
  default     = "4.5.6.7"
  type        = string
}



variable "cc_aws_organisation_arn" {
  description = "Core Cloud AWS Org ARN"
  type        = string
}


##################
## r53-firewall ##
##################
variable "domain_list_name" {
  description = "Name for the domain list"
  type        = string
}

variable "domain_file_path" {
  description = "Path to the domain list text file"
  type        = string
}

variable "rule_group_name" {
  description = "DNS Firewall Rule Group name"
  type        = string
}

variable "aws_association_priority" {
  description = "Priority for rule group association"
  type        = number
  default     = 200
}

variable "custom_association_priority" {
  description = "Priority for rule group association"
  type        = number
  default     = 300
}

variable "rulegroup_association_priority" {
  description = "Priority for rule group association"
  type        = number
  default     = 100
}


######
# Routing
######

variable "transit_gateway_id" {
  type        = string
  description = "Transit Gateway ID"
}

variable "poise_resolver_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for Poise outbound resolver subnets"
}

variable "ncsc_resolver_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for NCSC outbound resolver subnets"
}

variable "inbound_resolver_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for inbound resolver subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}