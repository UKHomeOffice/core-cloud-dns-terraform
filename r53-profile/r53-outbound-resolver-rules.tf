resource "aws_route53_resolver_rule" "fwd_rule_1" {
  domain_name            = var.poise_domain_name # Poise Internal Domain
  name                   = "fwd-to-poise-dns"
  rule_type              = "FORWARD"
  resolver_endpoint_id   = aws_route53_resolver_endpoint.outbound.id

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
      RuleType = "FORWARD"
      Description = "Forwards ${var.poise_domain_name} to POISE"
    }
  )
  
}

resource "aws_route53profiles_resource_association" "fwd_rule_1_r53rule_association" {
  name         = "fwd_rule_1_r53rule_association"
  profile_id   = aws_route53profiles_profile.cc_r53_profile.id
  resource_arn = aws_route53_resolver_rule.fwd_rule_1.arn
}