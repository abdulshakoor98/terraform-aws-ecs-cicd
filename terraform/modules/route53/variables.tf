variable "project_name" {
  description = "Project name"
  type        = string
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "domain_validation_options" {
  description = "ACM DNS validation options"

  type = list(object({
    domain_name           = string
    resource_record_name  = string
    resource_record_type  = string
    resource_record_value = string
  }))

  default = []
}