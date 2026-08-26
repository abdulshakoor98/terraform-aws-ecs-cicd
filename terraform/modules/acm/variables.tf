variable "project_name" {
  description = "Project name"
  type        = string
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "validation_record_fqdns" {
  description = "DNS validation record FQDNs"
  type        = list(string)
}