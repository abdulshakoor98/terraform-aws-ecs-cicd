output "github_actions_role_arn" {
  description = "IAM role ARN used by GitHub Actions"
  value       = module.github_oidc.github_actions_role_arn
}

output "oidc_provider_arn" {
  description = "GitHub OIDC provider ARN"
  value       = module.github_oidc.oidc_provider_arn
}