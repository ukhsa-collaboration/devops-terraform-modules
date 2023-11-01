# Web Service Infrastructure Template

This Terraform template provides a blueprint for setting up a comprehensive AWS Web Service Infrastructure including networking, compute, load balancing, domain routing, and user authentication services.

## Modules Used

1. **Tags Module**: Establishes consistent tagging for AWS resources.
2. **Subnets Module**: Creates and manages subnets for the VPC.
3. **EC2 AutoScale Module**: Sets up an EC2 instance with autoscaling capabilities.
4. **Load Balancer Module**: Implements a load balancer with specified listeners and listener rules. It also sets up target groups for routing, and provides support for Cognito authentication on certain routes.
5. **Domain Routing Module**: Handles routing for the domain, including Route 53 configurations, and associates routing table with the subnets.
6. **Cognito Module**: Configures an Amazon Cognito user pool for authentication with specified schema, recovery mechanisms, and OAuth scopes.

## Variables

This configuration uses several variables to customize the deployment:

- **General**: Resource names, project details, owner, and environment.
- **AWS Configuration**: AWS region, VPC ID, and default security group.
- **Network Configuration**: CIDR blocks for subnets.
- **EC2 Configuration**: AMI ID, instance type, and user data for initial setup.
- **Load Balancer Configuration**: Listeners, listener rules, and target groups.
- **Domain Configuration**: Domain details for Route 53.
- **Cognito Configuration**: User pool settings, schema, and OAuth settings.

## Usage

To use this example configuration:

1. Ensure you have the necessary modules available in the `./terraform-modules` directory.
2. Define the values for the variables in a `terraform.tfvars` file or supply them via command line.
3. Initialize the Terraform directory: `terraform init`
4. Apply the Terraform configuration: `terraform apply`

## Note

- This is an example configuration. Ensure that security groups and CIDR blocks are adjusted appropriately for a production environment.

For detailed information about each module, refer to the documentation in the respective module directories.
