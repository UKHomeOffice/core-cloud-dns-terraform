
module "r53-profile" {
  source                  = "./r53-profile"
  subnet_ids              = var.subnet_ids
  tags                    = var.tags
  vpc_id                  = var.vpc_id
  poise_domain_name       = var.poise_domain_name
  poise_dns1_ip           = var.poise_dns1_ip
  poise_dns2_ip           = var.poise_dns2_ip
  core_cloud_accounts     = var.core_cloud_accounts
  cc_aws_organisation_arn = var.cc_aws_organisation_arn
  ## r53-firewall config
  domain_list_name     = var.domain_list_name
  domain_file_path     = var.domain_file_path
  rule_group_name      = var.rule_group_name
  aws_association_priority = var.aws_association_priority
  custom_association_priority = var.custom_association_priority
  rulegroup_association_priority = var.rulegroup_association_priority
}
