variable "tags" {
  type        = map(string)
  description = "Tags to apply to AWS resources"
}

variable "vpc_id" {
  description = "VPC ID of the network account where the Route 53 profile will be associated"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to be used for Route 53 resolver endpoints"
  type        = list(string)
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

variable "core_cloud_accounts" {
  description = "List of AWS Accounts to Share R53 profile"
  type        = list(string)
}

variable "cc_aws_organisation_arn" {
  description = "Core Cloud AWS Org ARN"
  type        = string
}



# variable "network_phz_arn" {
#   description = "Network PHZ Arn"
#   type        = string
# }

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
  default     = 100
}

variable "custom_association_priority" {
  description = "Priority for rule group association"
  type        = number
  default     = 200
}