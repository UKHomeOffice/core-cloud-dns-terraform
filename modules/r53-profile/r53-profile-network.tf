locals {
  poise_map = zipmap(
    range(length(var.poise_resolver_subnet_cidrs)),
    [for i in range(length(var.poise_resolver_subnet_cidrs)) : {
      cidr = var.poise_resolver_subnet_cidrs[i]
      az   = var.availability_zones[i]
    }]
  )

  ncsc_map = zipmap(
    range(length(var.ncsc_resolver_subnet_cidrs)),
    [for i in range(length(var.ncsc_resolver_subnet_cidrs)) : {
      cidr = var.ncsc_resolver_subnet_cidrs[i]
      az   = var.availability_zones[i]
    }]
  )

  inbound_map = zipmap(
    range(length(var.inbound_resolver_subnet_cidrs)),
    [for i in range(length(var.inbound_resolver_subnet_cidrs)) : {
      cidr = var.inbound_resolver_subnet_cidrs[i]
      az   = var.availability_zones[i]
    }]
  )
}

##############################
# Create Resolver Subnets
##############################

resource "aws_subnet" "cc_inbound_endpoint_subnet" {
  for_each = local.inbound_map

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name     = "cc-inbound-resolver-${each.value.az}"
    Resolver = "inbound"
  }
}

resource "aws_subnet" "cc_poise_outbound_endpoint_subnet" {
  for_each = local.poise_map

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name     = "cc-poise-outbound-resolver-endpoint-${each.value.az}"
    Resolver = "poise"
  }
}

resource "aws_subnet" "cc_ncsc_outbound_endpoint_subnet" {
  for_each = local.ncsc_map

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name     = "cc-ncsc-outbound-resolver-endpoint-${each.value.az}"
    Resolver = "ncsc"
  }
}


##############################
# Private NAT Gateway
##############################


resource "aws_nat_gateway" "private_nat_gw" {
  for_each          = aws_subnet.cc_ncsc_outbound_endpoint_subnet
  connectivity_type = "private"
  subnet_id         = each.value.id

  tags = {
    Name = "private-natgw-${each.key}"
  }
}


##############################
# Route Tables
##############################

resource "aws_route_table" "cc_poise_outbound_endpoint_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "cc-poise-outbound-resolver-endpoints-rt"
  }
}

resource "aws_route_table" "cc_ncsc_outbound_endpoint_rt" {
  for_each = aws_subnet.cc_ncsc_outbound_endpoint_subnet

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private_nat_gw[each.key].id
  }

  tags = {
    Name = "cc-ncsc-outbound-resolver-endpoints-rt-${each.key}"
  }
}


resource "aws_route_table" "cc_inbound_resolver_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "cc-inbound-resolver-endpoints-rt"
  }
}

##############################
# Route Table Associations
##############################

resource "aws_route_table_association" "cc_poise_outbound_endpoint_assoc" {
  for_each = aws_subnet.cc_poise_outbound_endpoint_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.cc_poise_outbound_endpoint_rt.id
}

resource "aws_route_table_association" "cc_ncsc_outbound_endpoint_assoc" {
  for_each = aws_subnet.cc_ncsc_outbound_endpoint_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.cc_ncsc_outbound_endpoint_rt[each.key].id
}


resource "aws_route_table_association" "cc_inbound_resolver_assoc" {
  for_each = aws_subnet.cc_inbound_endpoint_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.cc_inbound_resolver_rt.id
}
