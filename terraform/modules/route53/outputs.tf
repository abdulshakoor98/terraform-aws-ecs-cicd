output "zone_id" {
  description = "Route 53 hosted zone ID"
  value       = aws_route53_zone.this.zone_id
}

output "name_servers" {
  description = "Route 53 name servers"
  value       = aws_route53_zone.this.name_servers
}

output "acm_validation_records" {
  description = "ACM DNS validation records"
  value       = aws_route53_record.acm_validation
}