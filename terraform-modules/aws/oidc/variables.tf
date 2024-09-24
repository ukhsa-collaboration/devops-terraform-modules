variable "tags" {
  description = "Tags to assign"
  type        = map(string)
  default     = {}
}

variable "repo_name" {
  description = "The full name of the Github Repo that should be allowed to assume the role. E.g. UKHSA-Internal/devops-terraform-example-project"
  type        = string
}

variable "allowed_refs" {
  description = "The Github reference that should be allowed to assume the role. Use '*' for all branches / enviroment. By default, only the 'main' branch can assume the role"
  type        = string
  default     = "ref:refs/heads/main"
}

variable "iam_policy_arn" {
  description = "The ARN of the IAM policy that the OIDC role should use. Will use a default policy if not specified."
  type        = string
  default     = ""
}