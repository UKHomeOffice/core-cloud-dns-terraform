resource "aws_route53_zone" "workload_zone" {
  name = var.domain_name

  tags = merge(
    {
      Environment = var.environment
    },
    var.tags
  )
}
