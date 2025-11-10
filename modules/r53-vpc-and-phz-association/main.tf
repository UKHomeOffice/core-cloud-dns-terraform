# Associate PHZ with the Profile

locals {
  phz_arns = {
    for name, id in var.private_hosted_zone_ids :
    name => "arn:aws:route53:::hostedzone/${id}"
  }
}

resource "aws_route53profiles_resource_association" "phz_to_profile" {
  for_each    = local.phz_arns

  profile_id   = var.r53_profile_id
  resource_arn = each.value
  name         = each.key
}

# Associate VPC with the Profile
resource "aws_route53profiles_association" "vpc_to_profile" {
  name         = var.vpc_name
  profile_id = var.r53_profile_id
  resource_id = data.aws_vpc.selected.id         # VPC ID
}



