##################################
# Outputs
##################################

output "private_hosted_zone_ids" {
  description = "Map of private hosted zone names to their IDs"
  value = {
    for name, zone in aws_route53_zone.private_hosted_zone :
    name => zone.zone_id
  }
}

output "private_hosted_zone_names" {
  description = "List of created private hosted zone names"
  value       = [for _, zone in aws_route53_zone.private_hosted_zone : zone.name]
}

output "vpc_id" {
  description = "ID of the VPC associated with all private hosted zones"
  value       = data.aws_vpc.selected.id
}
