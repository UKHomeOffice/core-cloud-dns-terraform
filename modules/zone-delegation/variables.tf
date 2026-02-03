variable "zone_id" {
  type        = string
  description = "Parent hosted zone ID in network account"
}

variable "delegations" {
  description = "Map of domain -> name_servers"
  type        = map(list(string))
}
