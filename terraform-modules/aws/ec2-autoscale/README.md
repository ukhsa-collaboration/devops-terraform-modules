# Terraform EC2 AutoScale Module

This Terraform module provides functionalities to manage AWS EC2 AutoScaling Group, Launch Template, and associated Security Group.

## Prerequisites

- **Terraform Tags Module:** Before using the `ec2-autoscale` module, you must integrate the [Terraform Tags Module](../helpers/tags) to ensure consistent tagging across AWS resources. Refer to its documentation to understand its setup and usage.

## Features

- Automated naming configuration for resources based on project and environment tags.
- Configurable Launch Template for EC2 instances.
- Configurable Security Group rules for the associated EC2 instances.
- AutoScaling Group management, with the ability to specify subnets and target groups.
- Provides outputs for generated resource names and IDs for easy referencing.

## Usage

```hcl
module "tags" {
  source          = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/tags?ref=TF/helpers/tags/vALPHA_0.0.0"

  project         = "MyProject"
  client          = "ClientName"
  owner           = "OwnerName"
  environment     = "prod"
  additional_tags = {
    "CostCenter" = "IT-Dept"
  }
}

module "ec2_autoscale" {
  source                = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/ec2-autoscale?ref=ec2-autoscale/vALPHA_0.0.0"

  name                  = "MyProjectName"
  ami                   = "ami-0123456789abcdef0"
  instance_type         = "t2.micro"
  vpc_id                = "vpc-01234567"
  vpc_zone_identifiers  = ["subnet-0123456a", "subnet-0123456b"]
  
  # Example with SSH Access
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags                  = module.tags.tags
}

# Referencing outputs from the module
output "asg_name" {
  value = module.ec2_autoscale.autoscaling_group_name
}
```
## Inputs

| Name                  | Description                                             | Type                                                                                              | Default            | Required |
|-----------------------|---------------------------------------------------------|---------------------------------------------------------------------------------------------------|--------------------|----------|
| `name`                | The name of the project                                 | `string`                                                                                          | n/a                | yes      |
| `ami`                 | AMI for the EC2 instance                                | `string`                                                                                          | n/a                | yes      |
| `instance_type`       | Type of the EC2 instance                                | `string`                                                                                          | n/a                | yes      |
| `user_data`           | User data for EC2 instance                              | `string`                                                                                          | `null`             | no       |
| `vpc_id`              | VPC ID for the security group                           | `string`                                                                                          | n/a                | yes      |
| `ingress_rules`       | List of ingress rules for the security group            | `list<rule>`                                                                                      | See defaults       | no       |
| `egress_rules`        | List of egress rules for the security group             | `list<rule>`                                                                                      | See defaults       | no       |
| `min_size`            | Minimum size of the Auto Scaling Group                  | `number`                                                                                          | `1`                | no       |
| `max_size`            | Maximum size of the Auto Scaling Group                  | `number`                                                                                          | `1`                | no       |
| `desired_capacity`    | Desired capacity of the Auto Scaling Group              | `number`                                                                                          | `1`                | no       |
| `vpc_zone_identifiers`| Subnets for the Auto Scaling Group                      | `list(string)`                                                                                    | n/a                | yes      |
| `target_group_arns`   | Target group ARNs for the Auto Scaling Group            | `list(string)`                                                                                    | `[]`               | no       |
| `tags`                | Tags to assign                                          | `map(string)`                                                                                     | n/a                | yes      |

## Outputs

| Name                       | Description                             |
|----------------------------|-----------------------------------------|
| `name`                     | Generated name from local configuration |
| `launch_template_name`     | The name of the launch template         |
| `autoscaling_group_name`   | The name of the auto scaling group      |
| `security_group_id`        | The ID of the security group            |
| `security_group_name`      | The name of the security group          |
