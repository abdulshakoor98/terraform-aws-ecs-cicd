output "certificate_arn" {
  description = "ACM certificate ARN"
  value       = aws_acm_certificate.this.arn
}

output "domain_validation_options" {
  description = "ACM DNS validation options"
  value       = aws_acm_certificate.this.domain_validation_options
}