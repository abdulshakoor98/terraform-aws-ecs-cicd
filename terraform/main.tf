module "vpc" {
  source = "./modules/vpc"

  project_name = "terraform-aws-ecs-cicd"
  vpc_cidr     = "10.0.0.0/16"
}

module "subnets" {
  source = "./modules/subnets"

  project_name = "terraform-aws-ecs-cicd"
  vpc_id       = module.vpc.vpc_id

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

module "networking" {
  source = "./modules/networking"

  project_name       = "terraform-aws-ecs-cicd"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
}

module "security_group" {
  source = "./modules/security-group"

  project_name   = "terraform-aws-ecs-cicd"
  vpc_id         = module.vpc.vpc_id
  container_port = 80
}

module "ecr" {
  source = "./modules/ecr"

  repository_name = "terraform-aws-ecs-cicd"
}

module "iam" {
  source = "./modules/iam"

  project_name = "terraform-aws-ecs-cicd"
}

module "alb" {
  source = "./modules/alb"

  project_name          = "terraform-aws-ecs-cicd"
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.subnets.public_subnet_ids
  alb_security_group_id = module.security_group.alb_security_group_id
  container_port        = 80
}

module "ecs" {
  source = "./modules/ecs"

  project_name    = "terraform-aws-ecs-cicd"
  aws_region      = "ap-south-1"
  container_image = "public.ecr.aws/docker/library/nginx:alpine"
  container_port  = 80
  task_cpu        = 256
  task_memory     = 512

  execution_role_arn = module.iam.ecs_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn

  private_subnet_ids    = module.subnets.private_subnet_ids
  ecs_security_group_id = module.security_group.ecs_security_group_id
  target_group_arn      = module.alb.target_group_arn
  alb_listener_arn      = module.alb.http_listener_arn

  depends_on = [
    module.alb
  ]
}

module "github_oidc" {
  source = "./modules/github-oidc"

  project_name      = "terraform-aws-ecs-cicd"
  github_repository = "abdulshakoor98/terraform-aws-ecs-cicd"
  github_branch     = "main"

  ecr_repository_arn     = module.ecr.repository_arn
  ecs_execution_role_arn = module.iam.ecs_execution_role_arn
  ecs_task_role_arn      = module.iam.ecs_task_role_arn
}
