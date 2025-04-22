output "route53_profile_arn" {
  description = "ARN of the Route 53 Profile"
  value       = aws_route53profiles_profile.cc_r53_profile.arn
}

output "route53_profile_id" {
  description = "ID of the Route 53 Profile"
  value       = aws_route53profiles_profile.cc_r53_profile.id
}

output "route53_profile_name" {
  description = "Name of the Route 53 Profile"
  value       = aws_route53profiles_profile.cc_r53_profile.name
}

