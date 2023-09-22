variable "name" {
  description = "The name of the resources"
  type        = string
}

variable "project" {
  description = "Project name to which the resource is associated"
  type        = string
}

variable "client" {
  description = "Client to which the resource is associated"
  type        = string
}

variable "owner" {
  description = "Owner of the resource"
  type        = string
}

variable "environment" {
  description = "The environment for this deployment (e.g., dev, prod)"
  type        = string
}

variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "default_sg" {
  description = "Default security group ID"
  type        = string
}

variable "subnet_1_cidr_block" {
  description = "CIDR block for the first subnet"
  type        = string
}

variable "subnet_2_cidr_block" {
  description = "CIDR block for the second subnet"
  type        = string
}

variable "subnet_3_cidr_block" {
  description = "CIDR block for the third subnet"
  type        = string
}

variable "ec2_ami" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "ec2_type" {
  description = "EC2 instance type"
  type        = string
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}