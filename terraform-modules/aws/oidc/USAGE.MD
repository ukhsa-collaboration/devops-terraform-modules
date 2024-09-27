# Creating an OIDC role for an AWS account

This Terraform module creates an IAM role and allows Github Actions workflows from specified Github repos to assume the role. 

## Usage

```hcl
module "oidc" {
  source = "./"

  repo_name    = "UKHSA-Internal/<YOUR REPO NAME>"
  allowed_refs = "repo:UKHSA-Internal/<YOUR REPO NAME>:environment:dev"
}
```

## Setup Steps

Initially this module should be called from a Terraform stack that is run locally by an IAM user with admin privileges in the target AWS account. It can then be commited to the relevant repo to detect config drift as part of the normal pipeline.

The example below shows how this was set up for the devops-terraform-example-project.

Prerequisites:

    - AWS Credentials
    - Terraform
    - Git
    - aws-vault
    - AWS state file resources already provisioned using the [AWS state file module](https://github.com/UKHSA-Internal/devops-terraform-modules/tree/main/terraform-modules/aws/state-file)
    - An existing repo based on the [devops-terraform-template](https://github.com/UKHSA-Internal/devops-terraform-template)

### Step 1: Creating the IAM role

1. Clone your project repo `git clone git@github.com:UKHSA-Internal/<NAME OF YOUR REPO>.git`
2. Create a stack.
```bash
mkdir -p <NAME OF YOUR REPO>/core-services/oidc
```
3. `cd` into the newly created directory and create the required files:
```
core-services/oidc/
├── backend.tf
├── dependencies.json
├── main.tf
├── providers.tf
├── terraform.tf
├── tfvars
│   ├── dev.tfvars
│   └── prd.tfvars
└── variables.tf
```
4. Initalise Terraform, setting the backend variables manually.
```bash
aws-vault exec <profile name> -- terraform init -backend-config=dynamodb_table=<dynamodb table name> -backend-config=bucket=<bucket name> -backend-config=key=<backend key>
```
5. Plan and run the Terraform code using a IAM role with admin privileges. Review the plan and apply if it looks right.
```bash
aws-vault exec <profile name> -- terraform apply
```
