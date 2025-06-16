output "vpc_id" {
  value = data.aws_vpc.selected.id
}

output "zone_id_internal" {
  value = aws_route53_zone.workload_private_zone.zone_id
}

output "zone_id_eks" {
  value = var.hubCluster ? aws_route53_zone.eks_private_zone[0].zone_id : null
}
