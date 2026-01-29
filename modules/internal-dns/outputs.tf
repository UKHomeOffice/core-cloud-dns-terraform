
output "zone_id" {
  description = "The ID of the Route 53 hosted zone"
  value       = aws_route53_zone.public.zone_id
}

output "name_servers" {
  description = "List of name servers for delegation"
  value       = aws_route53_zone.public.name_servers
}
