locals {
  domain = var.internal_domain_name
  dvo    = tolist(aws_acm_certificate.wildcard.domain_validation_options)[0]
}

############################
# Wildcard cert + DNS validation
############################

# Request wildcard cert for the domain, validated via the PUBLIC hosted zone
resource "aws_acm_certificate" "wildcard" {
  domain_name       = "*.${local.domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags        = var.tags
}

# Create DNS validation record in the PUBLIC hosted zone
resource "aws_route53_record" "wildcard_validation" {
  zone_id = var.internal_zone_id

  name    = local.dvo.resource_record_name
  type    = local.dvo.resource_record_type
  records = [local.dvo.resource_record_value]

  ttl = 60
}

# Complete validation
resource "aws_acm_certificate_validation" "wildcard" {
  certificate_arn         = aws_acm_certificate.wildcard.arn
  validation_record_fqdns = [aws_route53_record.wildcard_validation.fqdn]
}
