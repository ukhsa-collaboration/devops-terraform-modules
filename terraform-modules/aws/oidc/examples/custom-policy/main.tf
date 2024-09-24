module "aws-oidc-github" {
  source = "./../.."

  repo_name    = "UKHSA-Internal/devops-terraform-example-project"
  allowed_refs = "*"
  iam_policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AdministratorAccess"
}

data "aws_partition" "current" {}