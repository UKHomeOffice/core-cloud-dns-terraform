

# Security group to allow outbound and inbound traffic on port 53 (DNS)
resource "aws_security_group" "resolver_sg" {
  name        = "resolver-sg"
  description = "Security group for inbound and outbound endpoint"
  vpc_id      = var.vpc_id

  # Ingress rules for UDP and TCP on port 53
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule to allow all outbound traffic (default behavior)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["10.0.0.0/8"] # We could change this to actual DNS IPs once known
  }
}