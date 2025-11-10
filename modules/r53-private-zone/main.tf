
##################################
# Private Hosted Zones (one per entry in private_hosted_zones)
##################################

resource "aws_route53_zone" "private_hosted_zone" {
  for_each = toset(var.private_hosted_zones)

  name    = each.value
  comment = "Private hosted zone for ${each.value}"

  vpc {
    vpc_id     = data.aws_vpc.selected.id
    vpc_region = data.aws_region.current.id
  }

  tags = merge(
    {
      Name        = "${each.value}"
      Environment = each.value
      ManagedBy   = "core-cloud-dns-terragrunt"
    },
    var.tags
  )
}
