# Terraform Modules Repository

Welcome to the Terraform Modules Repository. This repository contains a collection of reusable Terraform modules for AWS resources, making infrastructure provisioning efficient, consistent, and reliable.

## Table of Contents

- [Terraform Modules Repository](#terraform-modules-repository)
  - [Table of Contents](#table-of-contents)
  - [Modules](#modules)
  - [Usage](#usage)
  - [Versioning](#versioning)
    - [Best Practices for Versioning Terraform Modules:](#best-practices-for-versioning-terraform-modules)
    - [Terraform Manifests](#terraform-manifests)
    - [Terraform CDK in Python](#terraform-cdk-in-python)
  - [Documentation Assets](#documentation-assets)

## Modules

The following Terraform modules are available:

1. [Subnet](./terraform-modules/subnet)
2. [AWS Application Load Balancer (ALB)](./terraform-modules/load-balancer)
3. [EC2 AutoScale](./terraform-modules/ec2-autoscale)
4. [Domain Routing](./terraform-modules/domain-routing)
5. [Resource Name Prefix](./terraform-modules/resource-nam-prefix)

All modules are located in the [terraform-modules](./terraform-modules) folder.

## Usage

## Versioning

Modules in this repository are versioned using git tags in the format `TF_x.x.x`. For a list of all versions, check the tags in this repository.

### Best Practices for Versioning Terraform Modules:

1. **Semantic Versioning:** Use [SemVer](https://semver.org/) (major.minor.patch) for clear version increments.
2. **Document Changes:** Update documentation and changelogs with each release.
3. **Pin Versions:** In configurations, specify module versions for consistency.
4. **Limit Major Changes:** Introduce backward-incompatible changes sparingly.
5. **Testing:** Test modules thoroughly before releasing, especially for major updates.

### Terraform Manifests

To see examples of how to use these modules with standard Terraform configurations, navigate to the [terraform-config](./examples/terraform-config) folder.

### Terraform CDK in Python

For those interested in using the Terraform Cloud Development Kit (CDK) in Python, examples are provided in the [CDK-terraform-config](./examples/CDK-terraform-config) folder.

## Documentation Assets

Additional documentation, diagrams, and assets related to the modules can be found in the [doc](./doc) folder.