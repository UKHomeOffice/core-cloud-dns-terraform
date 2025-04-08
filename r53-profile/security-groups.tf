# Security group to allow outbound and inbound traffic on port 53 (DNS)
resource "aws_security_group" "resolver_sg" {
  name        = "resolver-sg"
  description = "Security group for inbound and outbound DNS traffic"
  vpc_id      = var.vpc_id

  # Ingress rule for UDP traffic on port 53
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Allow inbound DNS queries over UDP"
  }

  # Ingress rule for TCP traffic on port 53
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Allow inbound DNS queries over TCP"
  }

  # Egress rule to allow all outbound traffic (default behavior)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # All protocols
    cidr_blocks = ["10.0.0.0/8"] # We could change this to actual DNS IPs once known
    description = "Allow Outbound DNS queries over TCP"
  }
}
