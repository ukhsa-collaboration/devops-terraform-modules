# Terraform Config

aws_region          = "eu-west-2"

backend_bucket_name = "nhslogin-poc-backend"

 

# Resource Name Prefix

name = "iac-poc"

 

# Tag

project     = "streamlit"

client      = "my-client"

owner       = "UKHSA"

environment = "dev"

 

# EC2

ec2_ami  = "ami-0eb260c4d5475b901"

ec2_type = "t2.nano"

 

# Route 53

primary_domain   = "qap-ukhsa.uk"

subdomain_prefix = "iac-streamlit-poc"

 

# Security Group

default_sg = "sg-018971e344b5aca42"

 

# VPC and Subnets

vpc_id              = "vpc-0bf89204327670055"

subnet_1_cidr_block = "10.0.224.0/27"

subnet_2_cidr_block = "10.0.224.32/27"

subnet_3_cidr_block = "10.0.224.160/27"
