##################################
# Variables
##################################

variable "vpc_name" {
  description = "Name tag of the VPC to associate with the private hosted zone"
  type        = string
}

variable "r53_profile_id" {
  description = "ID of the existing Route53 Profile to associate resources with"
  type        = string
}

variable "private_hosted_zone_ids" {
  description = "Map of private hosted zone names to their IDs"
  type        = map(string)
}
