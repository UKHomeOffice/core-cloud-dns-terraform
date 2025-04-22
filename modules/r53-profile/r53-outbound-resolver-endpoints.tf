######
# POISE OUTBOUND RESOLVER
######

resource "aws_route53_resolver_endpoint" "cc_poise_outbound_endpoint" {
  name               = "cc-poise-outbound-endpoint"
  direction          = "OUTBOUND"
  security_group_ids = [aws_security_group.cc_poise_resolver_sg.id]

  dynamic "ip_address" {
    for_each = aws_subnet.cc_poise_outbound_endpoint_subnet
    content {
      subnet_id = ip_address.value.id
    }
  }

  tags = merge(
    var.tags,
    {
      Environment  = "prod"
      EndpointType = "outbound"
      Resolver     = "poise"
    }
  )
}


######
# NCSC PDNS OUTBOUND RESOLVER
######

resource "aws_route53_resolver_endpoint" "cc_ncsc_outbound_endpoint" {
  name               = "cc-ncsc-outbound-endpoint"
  direction          = "OUTBOUND"
  security_group_ids = [aws_security_group.cc_ncsc_resolver_sg.id]

  dynamic "ip_address" {
    for_each = aws_subnet.cc_ncsc_outbound_endpoint_subnet
    content {
      subnet_id = ip_address.value.id
    }
  }

  tags = merge(
    var.tags,
    {
      Environment  = "prod"
      EndpointType = "outbound"
      Resolver     = "ncsc"
    }
  )
}
