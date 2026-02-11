#############################
# Resolver rules (one per domain)
#############################
resource "aws_route53_resolver_rule" "poise" {
  for_each = toset(var.poise_domain_names)

  name                 = "fwd-to-poise-${replace(each.key, ".", "-")}"
  domain_name          = each.key
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.cc_poise_outbound_endpoint.id

  # Add a target_ip block for each DNS IP
  dynamic "target_ip" {
    for_each = var.poise_dns_ips
    content {
      ip = target_ip.value
      # port = 53  # optional, defaults to 53
    }
  }

  tags = merge(
    var.tags,
    {
      RuleType    = "FORWARD"
      Description = "Forwards ${each.key} to POISE DNS"
    }
  )
}

#############################
# Associate each rule to the R53 Profile
#############################
resource "aws_route53profiles_resource_association" "poise_assoc" {
  # iterate over the created rules
  for_each = aws_route53_resolver_rule.poise

  name         = "cc-poise-rule-association-${replace(each.key, ".", "-")}"
  profile_id   = aws_route53profiles_profile.cc_r53_profile.id
  resource_arn = each.value.arn
}



#############################
# NCSC PDNS FORWARDING RULE
#############################
resource "aws_route53_resolver_rule" "cc_ncsc_resolver_rule" {
  name                 = "fwd-all-dns-to-ncsc-pdns"
  domain_name          = "." # catch-all for all domains
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.cc_ncsc_outbound_endpoint.id

  # Dynamically create target_ip blocks for all IPs in the list
  dynamic "target_ip" {
    for_each = var.ncsc_dns_ips
    content {
      ip = target_ip.value
      # port = 53 # optional
    }
  }

  tags = merge(
    var.tags,
    {
      RuleType    = "FORWARD"
      Description = "Forwards ALL DNS to NCSC PDNS"
    }
  )
}

#############################
# Associate rule to R53 Profile
#############################
resource "aws_route53profiles_resource_association" "cc_ncsc_resolver_rule_association" {
  name         = "cc-ncsc-rule-association"
  profile_id   = aws_route53profiles_profile.cc_r53_profile.id
  resource_arn = aws_route53_resolver_rule.cc_ncsc_resolver_rule.arn
}

#############################
# Resolver rules (one per domain)
#############################
resource "aws_route53_resolver_rule" "ebsa" {
  for_each = toset(var.ebsa_domain_names)

  name = substr("fwd-to-ebsa-${replace(each.key, ".", "-")}", 0, 64)
  domain_name          = each.key
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.cc_poise_outbound_endpoint.id

  # Add a target_ip block for each DNS IP
  dynamic "target_ip" {
    for_each = var.ebsa_dns_ips
    content {
      ip = target_ip.value
      # port = 53  # optional, defaults to 53
    }
  }

  tags = merge(
    var.tags,
    {
      RuleType    = "FORWARD"
      Description = "Forwards ${each.key} to EBSA DNS"
    }
  )
}

#############################
# Associate each rule to the R53 Profile
#############################
resource "aws_route53profiles_resource_association" "ebsa_assoc" {
  for_each = aws_route53_resolver_rule.ebsa

  name = substr("cc-ebsa-rule-association-${substr(md5(each.key), 0, 8)}",0,64)

  profile_id   = aws_route53profiles_profile.cc_r53_profile.id
  resource_arn = each.value.arn
}
