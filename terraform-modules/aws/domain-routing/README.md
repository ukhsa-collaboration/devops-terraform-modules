# Domain Routing Terraform Module

This Terraform module provides functionalities to manage AWS resources related to Route 53, ACM Certificates, Route Tables, and associated configurations.

## Prerequisites

- **Terraform Tags Module:** Before using the `ec2-autoscale` module, you must integrate the [Terraform Tags Module](../helpers/tags) to ensure consistent tagging across AWS resources. Refer to its documentation to understand its setup and usage.

## Features

- Automatic naming for AWS resources based on provided base name and tags.
- Management of Route 53 records and zones.
- Configuration of AWS Route Tables and their associations with subnets.
- Generation and validation of ACM certificates.
- Provides outputs for generated resources for easy referencing.

## Usage

```hcl
module "tags" {
  source          = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/tags?ref=TF/helpers/tags/vALPHA_0.0.0"

  project         = "MyProject"
  client          = "ClientName"
  owner           = "OwnerName"
  environment     = "prod"
  additional_tags = {
    "CostCenter" = "IT-Dept"
  }
}

module "domain_routing" {
  source                  = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/domain-routing?ref=domain-routing/vALPHA_0.0.0"
  
  name                    = "MyResource"
  vpc_id                  = "vpc-01234567"
  load_balancer_dns_name  = "my-loadbalancer-1234567890.us-west-2.elb.amazonaws.com"
  load_balancer_zone_id   = "Z3DZXD0Q5XHJRH"
  primary_domain          = "example.com"
  subdomain_prefix        = "sub"

  routes                  = [
    {
      cidr_block       = "0.0.0.0/0"
      gateway_id       = "igw-01234567"
    }
  ]
  associate_route_table   = true
  subnet_ids              = ["subnet-012345a", "subnet-012345b"]

  tags                  = module.tags.tags
}

# Referencing outputs from the module
output "certificate_arn" {
  description = "The ARN of the created ACM certificate."
  value       = module.domain_routing.acm_certificate_arn
}

output "route53_record" {
  description = "The fully qualified domain name of the frontend record in Route 53."
  value       = module.domain_routing.frontend_record_name
}
```

## Inputs

| Name                     | Description                                      | Type                                                 | Default | Required |
|--------------------------|--------------------------------------------------|------------------------------------------------------|---------|----------|
| `name`                   | Base name of the resources                       | `string`                                             | n/a     | yes      |
| `vpc_id`                 | VPC ID where the route table will be created     | `string`                                             | n/a     | yes      |
| `load_balancer_dns_name` | DNS name of the load balancer                    | `string`                                             | n/a     | yes      |
| `load_balancer_zone_id`  | Zone ID of the load balancer                     | `string`                                             | n/a     | yes      |
| `routes`                 | List of maps containing routes configurations    | `list(object({...}))`                                 | `[]`    | no       |
| `associate_route_table`  | Whether to associate the subnets with the route table | `bool`                                      | `false` | no       |
| `subnet_ids`             | List of subnet IDs to associate with             | `list(string)`                                       | `[]`    | no       |
| `primary_domain`         | Primary domain name                              | `string`                                             | n/a     | yes      |
| `subdomain_prefix`       | Subdomain name                                   | `string`                                             | n/a     | yes      |
| `tags`                   | Tags to assign                                   | `map(string)`                                        | n/a     | yes      |

## Outputs

| Name                              | Description                                           |
|-----------------------------------|-------------------------------------------------------|
| `acm_certificate_arn`             | The ARN of the created ACM certificate               |
| `acm_certificate_validation_arn`  | The ARN of the ACM certificate validation            |
| `route53_zone_id`                 | The ID of the selected Route 53 zone                  |
| `frontend_record_name`            | Fully qualified domain name of the frontend record    |
| `route_table_id`                  | The ID of the route table                             |
| `route_table_association_ids`     | IDs of the route table associations                   |
| `resource_name_prefix_output`     | The generated resource name prefix                    |

