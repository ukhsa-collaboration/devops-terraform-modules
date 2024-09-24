module "aws-oidc-github" {
  source = "./../.."

  repo_name = "UKHSA-Internal/devops-terraform-example-project"
  additional_allowed_repos = {
    "UKHSA-Internal/devops-github-actions" = {
      aud : "*"
    }
    "UKHSA-Internal/devops-github-reusable-actions" = {
      aud : "ref:refs/heads/main:environment:prd"
    }
  }
}
