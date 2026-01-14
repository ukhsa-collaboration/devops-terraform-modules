# Bootstrapping AWS accounts for Terraform backend

This Terraform module bootstraps an AWS account by creating an S3 bucket and, by default, a DynamoDB table for state locking. Access to the S3 bucket is restricted to IAM users and roles passed in as `iam_principals` input variable list.

## Usage

```hcl
module "bootstrap" {
  source = "./"
  region                = "eu-west-1"
  iam_principals        = ["arn:aws:iam::123456789012:user/example-user"]
  create_dynamodb_table = false
}
```

## Setup Steps

Normally, this would be run as part of a Gitub Actions pipeline. However, it can also be run locally for developing and testing purposes.

Prerequisites:

    - AWS Credentials
    - Terraform
    - Git
    - jq

### Step 1: Creating the backend resources

1. Clone the repo `git clone git@github.com:UKHSA-Internal/devops-terraform-modules.git`
2. Change into the `examples/full` directory 
```bash
cd devops-terraform-modules/terraform-modules/aws/state-file/examples/full
```
3. Setup your AWS credentials
```bash
export AWS_ACCESS_KEY_ID=<AWS ID>
export AWS_SECRET_ACCESS_KEY=<AWS SECRET KEY>
```
4. Rename the `terraform.tf` file to remove its .tf ending.
```bash
mv terraform.tf terraform.tf.orig
```
5. Initalise Terraform and Apply to create the bucket and other resources with a local state file.
```bash
terraform init
terraform apply
```

### Step 2: Storing the bucket's state in the bucket (Or, _stuffing the egg into the chicken_)

6. Export the outputs needed from the local state file to construct the name of the S3 bucket and DynamoDB table.
```bash
export dynamodb_table=$(terraform output -json | jq -r .dynamodb_table_name.value)
export s3_state_bucket=$(terraform output -json | jq -r .aws_s3_bucket.value)
```

7. Rename the `terraform.tf` back to its original name.
```bash
mv terraform.tf.orig terraform.tf
```
8. Reinitialise Terraform with the S3 backend and copy the local state file to the remote.
```bash
terraform init \
  -backend-config=dynamodb_table=$dynamodb_table \
  -backend-config=bucket=$s3_state_bucket \
  -backend-config=key=s3-backend-state/terraform.tfstate \
  -force-copy
```

If you set `create_dynamodb_table = false`, skip the `dynamodb_table` backend config and use only the S3 backend.
