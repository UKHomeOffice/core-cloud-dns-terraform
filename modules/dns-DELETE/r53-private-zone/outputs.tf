output "zone_id" {
  description = "The ID of the Route 53 private hosted zone"
  value       = aws_route53_zone.private_zone.zone_id
}
