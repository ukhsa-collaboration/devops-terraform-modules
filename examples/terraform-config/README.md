# Terraform Modules Example Configuration

This example configuration demonstrates how to make use of various modules from the Terraform modules repository to set up a cloud environment with EC2, subnets, load balancers, and domain routing in AWS.

## Modules Used

1. **Tags Module**: Establishes consistent tagging for AWS resources.
2. **Subnets Module**: Creates and manages subnets for the VPC.
3. **EC2 AutoScale Module**: Sets up an EC2 instance with autoscaling capabilities.
4. **Load Balancer Module**: Implements a load balancer with specified listeners.
5. **Domain Routing Module**: Handles routing for the domain, including Route 53 configurations.

## Variables

This configuration uses several variables to customize the deployment:

- **General**: Resource names, project details, owner, and environment.
- **AWS Configuration**: AWS region, VPC ID, and default security group.
- **Network Configuration**: CIDR blocks for subnets.
- **EC2 Configuration**: AMI ID and instance type.
- **Domain Configuration**: Domain details for Route 53.

## Usage

To use this example configuration:

1. Ensure you have the necessary modules available in the `./terraform-modules` directory.
2. Define the values for the variables in a `terraform.tfvars` file or supply them via command line.
3. Initialize the Terraform directory: `terraform init`
4. Apply the Terraform configuration: `terraform apply`

## Note

- This is an example configuration. Ensure that security groups and CIDR blocks are adjusted appropriately for a production environment.

For detailed information about each module, refer to the documentation in the respective module directories.

