
resource "aws_route53_zone" "workload_zone" {
  for_each = toset(var.domain_names)

  name = each.value

  tags = merge(
    { Environment = var.environment },
    var.tags
  )
}
