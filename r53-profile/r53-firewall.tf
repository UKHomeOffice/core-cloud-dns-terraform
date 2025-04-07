resource "aws_route53_resolver_firewall_domain_list" "blocked_domains" {
  name        = var.domain_list_name
  domains     = split("\n", file(var.domain_file_path))
  tags        = var.tags
}

resource "aws_route53_resolver_firewall_rule_group" "rule_group" {
  name = var.rule_group_name
  tags = var.tags
}

resource "aws_route53_resolver_firewall_rule" "block_rules" {
  for_each = toset(split("\n", file(var.domain_file_path)))

  name                  = replace(each.key, ".", "-")
  action                = "BLOCK"
  block_response        = "NXDOMAIN"
  firewall_domain_list_id = aws_route53_resolver_dns_firewall_domain_list.blocked_domains.id
  priority              = index(split("\n", file(var.domain_file_path)), each.key) + 1
  firewall_rule_group_id = aws_route53_resolver_dns_firewall_rule_group.rule_group.id
}

resource "aws_route53_resolver_firewall_rule_group_association" "assoc" {
  name                    = "${var.rule_group_name}-assoc"
  firewall_rule_group_id  = aws_route53_resolver_dns_firewall_rule_group.rule_group.id
  priority                = var.association_priority
  vpc_id                  = var.vpc_id
  mutation_protection     = "DISABLED"
  tags                   = var.tags
}

