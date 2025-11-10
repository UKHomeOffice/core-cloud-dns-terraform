
resource "aws_route53_record" "ns_record" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "NS"
  ttl     = 300

  records = var.workload_public_zone_ns_records
}
