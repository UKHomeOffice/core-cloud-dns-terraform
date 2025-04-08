
# Create the inbound resolver endpoint
resource "aws_route53_resolver_endpoint" "inbound" {
  name               = "core_cloud_r53_inbound_ep"
  direction          = "INBOUND"
  security_group_ids = [aws_security_group.resolver_sg.id]

  # Use the subnet_ids variable to dynamically assign subnets to the inbound resolver
  dynamic "ip_address" {
    for_each = var.subnet_ids
    content {
      subnet_id = ip_address.value
    }
  }

  tags = merge(
    var.tags,
    {
      Environment  = "prod"
      EndpointType = "inbound"
    }
  )
}

