variable "domain_names" {
  description = "List of domains (hosted zones) to create in the workload account"
  type        = list(string)
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
