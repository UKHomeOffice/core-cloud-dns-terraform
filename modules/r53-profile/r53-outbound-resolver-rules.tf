######
# POISE DNS FORWARDING RULE
######

resource "aws_route53_resolver_rule" "cc_poise_resolver_rule" {
  name                 = "fwd-to-poise-dns"
  domain_name          = var.poise_domain_name
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.cc_poise_outbound_endpoint.id

  target_ip {
    ip = var.poise_dns1_ip
  }

  target_ip {
    ip = var.poise_dns2_ip
  }

  tags = merge(
    var.tags,
    {
      Environment = "prod"
      RuleType    = "FORWARD"
      Description = "Forwards ${var.poise_domain_name} to POISE DNS"
    }
  )
}

resource "aws_route53profiles_resource_association" "cc_poise_resolver_rule_association" {
  name         = "cc-poise-rule-association"
  profile_id   = aws_route53profiles_profile.cc_r53_profile.id
  resource_arn = aws_route53_resolver_rule.cc_poise_resolver_rule.arn
}


######
# NCSC PDNS FORWARDING RULE
######

resource "aws_route53_resolver_rule" "cc_ncsc_resolver_rule" {
  name                 = "fwd-all-dns-to-ncsc-pdns"
  domain_name          = "." # Matches all domains
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.cc_ncsc_outbound_endpoint.id

  target_ip {
    ip = var.ncsc_dns1_ip
  }

  target_ip {
    ip = var.ncsc_dns2_ip
  }

  tags = merge(
    var.tags,
    {
      Environment = "prod"
      RuleType    = "FORWARD"
      Description = "Forwards ALL DNS to NCSC PDNS"
    }
  )
}

resource "aws_route53profiles_resource_association" "cc_ncsc_resolver_rule_association" {
  name         = "cc-ncsc-rule-association"
  profile_id   = aws_route53profiles_profile.cc_r53_profile.id
  resource_arn = aws_route53_resolver_rule.cc_ncsc_resolver_rule.arn
}
