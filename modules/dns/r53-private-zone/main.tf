
# Lookup VPC by Name tag
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Primary private zone: internal.${domain_name}
resource "aws_route53_zone" "workload_private_zone" {
  name    = "internal.${var.domain_name}"
  comment = "Private hosted zone for workload VPC"

  vpc {
    vpc_id = data.aws_vpc.selected.id
  }

  tags = merge(
    {
      Environment = var.environment
    },
    var.tags
  )
}

# Optional private zone for EKS DNS domain (conditionally created)
resource "aws_route53_zone" "eks_private_zone" {
  count   = var.hubCluster ? 1 : 0
  name    = "gr7.eu-west-2.eks.amazonaws.com"
  comment = "Private zone for EKS internal DNS"

  vpc {
    vpc_id = data.aws_vpc.selected.id
  }

  tags = merge(
    {
      Environment = var.environment
    },
    var.tags
  )
}

