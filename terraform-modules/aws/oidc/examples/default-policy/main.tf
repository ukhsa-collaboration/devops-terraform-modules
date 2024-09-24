module "aws-oidc-github" {
  source = "./../.."

  repo_name    = "UKHSA-Internal/devops-terraform-example-project"
  allowed_refs = "*"
}
