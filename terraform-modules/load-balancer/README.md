# Terraform AWS Application Load Balancer Module

This Terraform module provides functionalities to manage an AWS Application Load Balancer (ALB), Target Groups, Listeners, and an associated Security Group.

## Prerequisites

- **Terraform Tags Module**: Before using the `load-balancer` module, you must integrate the [Terraform Tags Module](<LINK_TO_TAGS_MODULE_REPOSITORY>) to ensure consistent tagging across AWS resources. Refer to its documentation to understand its setup and usage.

## Features

- Automated naming for Load Balancer, Target Groups, and Listeners based on project and environment tags.
- Configurable Target Groups and associated health checks.
- Configurable Listeners with default actions.
- Configurable Security Group rules for ingress and egress.
- Outputs for referencing Load Balancer, Target Groups, Listeners, and Security Group details.

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

module "aws_alb" {
  source       = <PLACEHOLDER_should_be_github.com/>
  name         = "MyLoadBalancer"
  subnets      = ["subnet-0123456a", "subnet-0123456b"]
  vpc_id       = "vpc-01234567"
  target_groups = [/* ... */]
  listeners    = [/* ... */]
  ingress_rules = [/* ... */]
  egress_rules  = [/* ... */]
  tags         = module.tags.tags
}

# Referencing outputs
output "alb_arn" {
  value = module.aws_alb.load_balancer_arn
}
```

## Inputs

| Name              | Description                                        | Type           | Default | Required |
|-------------------|----------------------------------------------------|----------------|---------|----------|
| `name`            | The name for Load Balancer and associated resources| `string`       | n/a     | yes      |
| `subnets`         | List of subnets for Load Balancer                  | `list(string)` | `[]`    | yes      |
| `vpc_id`          | VPC ID for resources                               | `string`       | n/a     | yes      |
| `target_groups`   | List of target group configurations                | `list(object)` | `[]`    | no       |
| `listeners`       | List of listener configurations                    | `list(object)` | `[]`    | no       |
| `ingress_rules`   | Ingress rules for security group                   | `list(object)` | `[]`    | no       |
| `egress_rules`    | Egress rules for security group                    | `list(object)` | `[]`    | no       |
| `tags`            | Tags for resources                                 | `map(string)`  | `{}`    | yes      |

Each of the object types for `target_groups`, `listeners`, `ingress_rules`, and `egress_rules` come with their own sub-parameters. They are as follows:

### Target Groups
- `port`: The port where the service is accessible.
- `protocol`: The protocol used.
- `health_check`: Object containing:
  - `matcher`: The HTTP response codes.
  - `path`: The destination for the health check request.
  - `interval`: The duration in seconds between health checks.
  
 *For Example*:
 ```hcl
  target_groups = [
    {
      port     = 443
      protocol = "HTTPS"
      health_check = {
        matcher  = "200-399"
        path     = "/"
        interval = 30
      }
    }
  ]
```
### Listeners
- `port`: The port where the service is accessible.
- `protocol`: The protocol used.
- `action_type`: The type of routing action.

 *For Example*:
 ```hcl
  listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "forward"
    },
    {
      port        = 443
      protocol    = "HTTPS"
      action_type = "forward"
    }
  ]
```

### Ingress Rules
- `from_port`: Starting port of the rule.
- `to_port`: Ending port of the rule.
- `protocol`: Protocol type.
- `cidr_blocks`: IP ranges.
- `security_groups`: List of security groups.

 *For Example*:
```hcl
  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
```

### Egress Rules
- `from_port`: Starting port of the rule.
- `to_port`: Ending port of the rule.
- `protocol`: Protocol type.
- `cidr_blocks`: IP ranges.

```hcl
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
```

## Outputs

| Name                    | Description                                     |
|-------------------------|-------------------------------------------------|
| `load_balancer_arn`     | The ARN of the Application Load Balancer        |
| `load_balancer_dns_name`| The DNS name of the Application Load Balancer   |
| `load_balancer_zone_id` | Canonical hosted zone ID of the Application Load Balancer |
| `target_group_arns`     | The ARNs of the target groups                   |
| `listener_arns`         | The ARNs of the listeners                       |
| `security_group_id`     | The ID of the Security Group                    |
