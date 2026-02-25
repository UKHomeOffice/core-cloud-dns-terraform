variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone"
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

variable "enable_dnssec" {
  type        = bool
  default     = false
  description = "Enable Route53 DNSSEC signing"
}