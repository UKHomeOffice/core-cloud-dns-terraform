##############################
# Poise Outbound Resolver SG
##############################

resource "aws_security_group" "cc_poise_resolver_sg" {
  name        = "cc-poise-resolver-sg"
  description = "SG for Poise outbound resolver DNS traffic"
  vpc_id      = var.vpc_id

  # Allow outbound DNS to Poise DNS IPs
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["${var.poise_dns1_ip}/32", "${var.poise_dns2_ip}/32"]
    description = "Allow outbound DNS queries to Poise over UDP"
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["${var.poise_dns1_ip}/32", "${var.poise_dns2_ip}/32"]
    description = "Allow outbound DNS queries to Poise over TCP"
  }
}

##############################
# NCSC Outbound Resolver SG
##############################

resource "aws_security_group" "cc_ncsc_resolver_sg" {
  name        = "cc-ncsc-resolver-sg"
  description = "SG for NCSC outbound resolver DNS traffic"
  vpc_id      = var.vpc_id

  # Allow outbound DNS to NCSC DNS IPs
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["${var.ncsc_dns1_ip}/32", "${var.ncsc_dns2_ip}/32"]
    description = "Allow outbound DNS queries to NCSC PDNS over UDP"
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["${var.ncsc_dns1_ip}/32", "${var.ncsc_dns2_ip}/32"]
    description = "Allow outbound DNS queries to NCSC PDNS over TCP"
  }
}

##############################
# Inbound Resolver SG
##############################

resource "aws_security_group" "cc_inbound_resolver_sg" {
  name        = "cc-inbound-resolver-sg"
  description = "SG for inbound DNS resolver"
  vpc_id      = var.vpc_id

  # Allow inbound DNS from on-prem / VPC CIDRs
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/8"] # Adjust to your on-prem/VPC IP range
    description = "Allow inbound DNS queries over UDP"
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Allow inbound DNS queries over TCP"
  }

  # Outbound typically needed for DNS responses
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16"]
    description = "Allow DNS responses over UDP"
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16"]
    description = "Allow DNS responses over TCP"
  }

}
