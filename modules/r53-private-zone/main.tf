resource "aws_route53_zone" "private_zone" {
  name    = "internal.${var.domain_name}"
  comment = "Private hosted zone"

  dynamic "vpc" {
    for_each = var.vpc_ids
    content {
      vpc_id     = vpc.value
      vpc_region = "eu-west-2"
    }
  }

  tags = merge(
    {
      Environment = var.environment
    },
    var.tags
  )
}
