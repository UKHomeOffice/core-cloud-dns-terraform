
module "r53-profile" {
  source = "./r53-profile"
  subnet_ids = var.subnet_ids
  tags = var.tags
  vpc_id = var.vpc_id
  poise_domain_name = var.poise_domain_name
  poise_dns1_ip = var.poise_dns1_ip
  poise_dns2_ip = var.poise_dns2_ip
  core_cloud_accounts = var.core_cloud_accounts
  cc_aws_organisation_arn = var.cc_aws_organisation_arn
}
