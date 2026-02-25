output "zone_id" {
  description = "The ID of the Route 53 hosted zone"
  value       = aws_route53_zone.workload_zone.zone_id
}

output "name_servers" {
  description = "List of name servers for delegation"
  value       = aws_route53_zone.workload_zone.name_servers
}

output "dnssec_ds_record" {
  value       = var.enable_dnssec ? aws_route53_key_signing_key.ksk[0].ds_record : null
  description = "DS record to add at your domain registrar when DNSSEC is enabled"
}