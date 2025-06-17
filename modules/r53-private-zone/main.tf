resource "aws_route53_zone" "private_zone" {
  name    = "internal.${var.domain_name}"
  comment = "Private hosted zone"

  vpc {
    vpc_id     = var.vpc_id
    vpc_region = "eu-west-2"
  }

  # dynamic "vpc" {
  #   for_each = var.vpc_ids
  #   content {
  #     vpc_id     = vpc.value
  #     vpc_region = "eu-west-2"
  #   }
  # }

  # dynamic "vpc" {
  #   for_each = try(tolist(lookup(each.value, "vpc", [])), [lookup(each.value, "vpc", {})])

  #   content {
  #     vpc_id     = vpc.value.vpc_id
  #     vpc_region = lookup(vpc.value, "vpc_region", null)
  #   }
  # }

  tags = merge(
    {
      Environment = var.environment
    },
    var.tags
  )
}
