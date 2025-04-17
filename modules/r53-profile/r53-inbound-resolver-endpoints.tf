resource "aws_route53_resolver_endpoint" "cc_inbound_endpoint" {
  name               = "core-cloud-r53-inbound-endpoint"
  direction          = "INBOUND"
  security_group_ids = [aws_security_group.cc_inbound_resolver_sg.id]

  dynamic "ip_address" {
    for_each = aws_subnet.cc_inbound_endpoint_subnet
    content {
      subnet_id = ip_address.value.id
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


