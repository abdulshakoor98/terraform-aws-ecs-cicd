terraform {
  backend "s3" {
    bucket = "terraform-aws-ecs-cicd-state-2026-abdul"
    key    = "terraform-aws-ecs-cicd/terraform.tfstate"
    region = "ap-south-1"
  }
}