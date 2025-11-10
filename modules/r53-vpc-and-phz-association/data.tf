##################################
# Data Sources
##################################

data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

##################################
# Fetch VPC ID based on its Name tag
##################################

data "aws_vpcs" "filtered_vpcs" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_vpc" "selected" {
  id = data.aws_vpcs.filtered_vpcs.ids[0]
}
