resource "aws_route53_resolver_firewall_domain_list" "custom_blocked_domains" {
  name        = var.domain_list_name
  domains     = split("\n", file(var.domain_file_path))
  tags = merge(
    var.tags,
    {
      Environment = "prod"
      Account = "Network"
      Component = "r53-firewall"
    }
  )
}

resource "aws_route53_resolver_firewall_rule_group" "rule_group" {
  name = var.rule_group_name
  tags = merge(
    var.tags,
    {
      Environment = "prod"
      Account = "Network"
      Component = "r53-firewall"
    }
  )
}

# Add custom rules
resource "aws_route53_resolver_firewall_rule" "block_rules" {
  for_each = toset(split("\n", file(var.domain_file_path)))

  name                  = replace(each.key, ".", "-")
  action                = "BLOCK"
  block_response        = "NXDOMAIN"
  firewall_domain_list_id = aws_route53_resolver_firewall_domain_list.custom_blocked_domains.id
  priority              = index(split("\n", file(var.domain_file_path)), each.key) + 1
  firewall_rule_group_id = aws_route53_resolver_firewall_rule_group.rule_group.id
}

# Add all AWS managed lists
# fetched from aws console with cli - aws route53resolver list-firewall-domain-lists
locals {
  aws_managed_list_names = [
    "AWSManagedDomainsMalwareDomainList",
    "AWSManagedDomainsBotnetCommandandControl",
    "AWSManagedDomainsSuspiciousDomainList",
    "AWSManagedDomainsAggregateThreatList",
    "AWSManagedDomainsAmazonGuardDutyThreatList"
  ]
}

data "aws_route53_resolver_firewall_domain_list" "aws_managed_lists" {
  for_each = toset(local.aws_managed_list_names)
  name     = each.key
}

resource "aws_route53_resolver_firewall_rule" "aws_managed_rules" {
  for_each = data.aws_route53_resolver_firewall_domain_list.aws_managed_lists

  name                    = "aws-managed-${each.key}"
  action                  = "BLOCK"
  firewall_domain_list_id = each.value.id
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.rule_group.id
  priority                = var.association_priority + index(local.aws_managed_list_names, each.key)
  block_response          = "NODATA"
}

# rule-group association
resource "aws_route53_resolver_firewall_rule_group_association" "assoc" {
  name                    = "${var.rule_group_name}-assoc"
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.rule_group.id
  priority                = var.association_priority
  vpc_id                  = var.vpc_id
  mutation_protection     = "DISABLED"
  tags = merge(
    var.tags,
    {
      Environment = "prod"
      Account = "Network"
      Component = "r53-firewall"
    }
  )
}


