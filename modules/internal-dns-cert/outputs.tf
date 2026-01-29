
output "wildcard_certificate_arn" {
  description = "Wildcard ACM certificate ARN."
  value       = aws_acm_certificate.wildcard.arn
}

