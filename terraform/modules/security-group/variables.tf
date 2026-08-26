variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "container_port" {
  description = "Application container port"
  type        = number
  default     = 80
}