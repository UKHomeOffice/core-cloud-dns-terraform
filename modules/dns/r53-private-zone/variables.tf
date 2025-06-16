variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone"
  type        = string
}

variable "vpc_name" {
  description = "VPC ID of the VPC to be associated with private hosted zone"
  type        = string
}


variable "environment" {
  description = "The environment in which the hosted zone is deployed"
  type        = string
}



variable "tags" {
  description = "Additional tags to be applied to the hosted zone"
  type        = map(string)
  default     = {}
}

variable "hubCluster" {
  description = "Flag to indicate if this is the hub cluster"
  type        = bool
  default     = false
}