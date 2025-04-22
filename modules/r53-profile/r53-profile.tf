resource "aws_route53profiles_profile" "cc_r53_profile" {
  name = "core-cloud-r53-profile"

  tags = merge(
    var.tags,
    {
      Environment = "prod"
      Account     = "Network"
    }
  )

}

resource "aws_route53profiles_association" "network_vpc" {
  name        = "network_vpc"
  profile_id  = aws_route53profiles_profile.cc_r53_profile.id
  resource_id = var.vpc_id
}

#
# Probably we don't need this as we may not have anything in non-endpoint private zones
#

# resource "aws_route53profiles_resource_association" "network_phz" {
#   name         = "network_phz"
#   profile_id   = aws_route53profiles_profile.cc_r53_profile.id
#   resource_arn = var.network_phz_arn
# }

