provider "aws" {
  region = "ap-south-1"

  default_tags {
    tags = {
      Project     = "terraform-aws-ecs-cicd"
      Environment = "production"
      ManagedBy   = "Terraform"
    }
  }
}