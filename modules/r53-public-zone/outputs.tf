output "delegations" {
  description = "Map of domain -> name_servers (for delegation in network account)"
  value = {
    for domain, zone in aws_route53_zone.workload_zone :
    domain => zone.name_servers
  }
}

