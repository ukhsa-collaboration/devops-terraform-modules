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


## Templates
- WIP - To be Updated Soon!

## Modules

The following Terraform modules are available:
- Helpers:
    1. [Resource Name Prefix](./terraform-modules/helpers/resource-name-prefix)
    2. [Tags](./terraform-modules/helpers/tags)
- AWS:
    1. [API Gateway](./terraform-modules/aws/api-gateway)
    2. [CloudFront Distribution](./terraform-modules/aws/cloudfront-distribution)
    3. [Cognito](./terraform-modules/aws/cognito)
    4. [Domain Routing](./terraform-modules/aws/domain-routing)
    5. [EC2 AutoScale](./terraform-modules/aws/ec2-autoscale)
    6. [Load Balancer](./terraform-modules/aws/load-balancer)
    7. [Resource Name Prefix](./terraform-modules/aws/resource-name-prefix)
    8. [Subnet](./terraform-modules/aws/subnet)
    9. [Web Application Firewall](./terraform-modules/aws/web-application-firewall)
- Azure:
    1. [Web Application Firewall](./terraform-modules/azure/web-application-firewall)

All modules are located in the [terraform-modules](./terraform-modules) folder.

## Usage

## Versioning

- Modules in this repository are versioned using git tags in the format `<IaC_tool>/<cloud_provider>/<module_name>/v<sem_version>`. 
- Pre-release Tags should be formatted in the format `<IaC_tool>/<cloud_provider>/<module_name>/v<release_stage>_<sem_version>`.

For a list of all versions, check the tags in this repository.

### Best Practices for Versioning Terraform Modules:

1. **Semantic Versioning:** Use [SemVer](https://semver.org/) (major.minor.patch) for clear version increments.
2. **Document Changes:** Update documentation and changelogs with each release.
3. **Pin Versions:** In configurations, specify module versions for consistency.
4. **Limit Major Changes:** Introduce backward-incompatible changes sparingly.
5. **Testing:** Test modules thoroughly before releasing, especially for major updates.

## Documentation Assets

Additional documentation, diagrams, and assets related to the modules can be found in the [doc](./doc) folder.