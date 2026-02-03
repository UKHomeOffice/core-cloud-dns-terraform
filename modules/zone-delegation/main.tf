resource "aws_route53_record" "ns_record" {
  for_each = var.delegations

  zone_id = var.zone_id
  name    = each.key
  type    = "NS"
  ttl     = 300
  records = each.value
}

