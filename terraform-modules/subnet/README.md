# Terraform AWS Subnet Module

This Terraform module manages the creation of AWS Subnets along with optional Route Table Association. It's designed to offer flexible configuration options, along with automated naming.

## Prerequisites

- **Terraform Tags Module**: Before using the `subnet` module, you must integrate the [Terraform Tags Module](<LINK_TO_TAGS_MODULE_REPOSITORY>) to ensure consistent tagging across AWS resources. Refer to its documentation to understand its setup and usage.

## Features

- Automated naming based on project and environment tags.
- Support for variable number of subnets based on available Availability Zones.
- Option to associate Route Table with the created subnets.
- Outputs Subnet IDs, ARNs, Availability Zones, and Route Table Association IDs.

## Usage

```hcl
module "tags" {
  source          = <PLACEHOLDER_FOR_TAGS_MODULE>
  project         = "MyProject"
  client          = "ClientName"
  owner           = "OwnerName"
  environment     = "prod"
  additional_tags = {
    "CostCenter" = "IT-Dept"
  }
}

module "subnet" {
  source            = "<PLACEHOLDER_FOR_SUBNET_MODULE>"
  name              = "MyResourceName"
  vpc_id            = "vpc-01234567"
  subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  route_table_id    = "rtb-0123456789abcdef0"
  associate_route_table = true

  tags = module.tags.tags
}

# Referencing outputs from the module
output "subnet_ids" {
  value = module.subnet.subnet_ids
}
```

## Inputs

| Name                   | Description                                                                  | Type           | Default | Required |
|------------------------|------------------------------------------------------------------------------|----------------|---------|----------|
| `name`                 | The name of the resources.                                                   | `string`       | n/a     | yes      |
| `vpc_id`               | The VPC ID where subnets will be created.                                    | `string`       | n/a     | yes      |
| `subnet_cidr_blocks`   | List of CIDR blocks for subnets.                                             | `list(string)` | n/a     | yes      |
| `route_table_id`       | Route table ID to associate with subnets.                                    | `string`       | n/a     | no       |
| `associate_route_table`| Whether to associate the subnets with the provided route table.              | `bool`         | `false` | no       |
| `tags`                 | Tags to assign.                                                              | `map(string)`  | n/a     | yes      |

## Outputs

| Name                         | Description                             |
|------------------------------|-----------------------------------------|
| `name`                       | Generated name from local configuration |
| `subnet_ids`                 | List of Subnet IDs                      |
| `subnet_arns`                | List of Subnet ARNs                     |
| `availability_zones`         | List of available Availability Zones    |
| `route_table_association_ids`| List of Route Table Association IDs     |
