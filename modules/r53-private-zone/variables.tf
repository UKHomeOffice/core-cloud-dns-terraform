##################################
# Variables
##################################

variable "private_hosted_zones" {
  description = "List of private hosted zone names (e.g. [\"cc-test-eks-1.corecloud.local\"])"
  type        = list(string)
}

variable "vpc_name" {
  description = "Name tag of the VPC to associate with the private hosted zone"
  type        = string
}

variable "tags" {
  description = "Additional tags to be applied to the hosted zone"
  type        = map(string)
  default     = {}
}

