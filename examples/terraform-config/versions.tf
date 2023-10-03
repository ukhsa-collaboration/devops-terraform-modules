terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.16"
    }
  }

  backend "s3" {
    bucket = "apps-tf-backend-s3"
    key    = "apps-tf-backend-key"
    region = "eu-west-2"
  }

  required_version = ">=1.2.0"

}

provider "aws" {
  region = var.aws_region
}