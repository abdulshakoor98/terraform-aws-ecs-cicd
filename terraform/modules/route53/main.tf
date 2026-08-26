resource "aws_route53_zone" "this" {
  name = var.domain_name

  tags = {
    Name = "${var.project_name}-zone"
  }
}

resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in var.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}