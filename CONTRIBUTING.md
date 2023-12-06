# Contributing to DevOps Terraform Modules

## Introduction
Welcome to DevOps Terraform Modules! This document outlines guidelines for contributing to this repository. Following these guidelines helps to keep our repo well maintained and standardized.

## Getting Started
Before you begin:
- Familiarize yourself with Terraform Modules directory and the specific modules in this repository.
- Read through the documentation, including `README.md` files in various directories.
- Workflow for contributing is `feature/*` -> `dev` -> `prod`

## Reporting Issues
If you encounter bugs, please create an issue on GitHub using the repo's issue template

## Making Contributions
To contribute, follow these steps:
1. **Feature Branch:** Create a feature branch in called `feature/<your_feature_name_here>`
2. **CI/CD:** A feature branch pipeline will run to test your changes - **ONLY MERGE YOUR FEATURE BRANCH IF THE CI PIPELINE IS PASSING**
3. **CHANGELOG:** You must follow the format of the changelog and update it with a description of your feature before merging to `dev`

### Coding Conventions
- Write clear, readable, and consistent code.
- Adhere to the existing coding style.
- Ensure your code passes `terraform fmt` and `terraform validate`.
- Document new code based on the repository's style.

### Adding/Updating Modules
- Describe the purpose of the module clearly.
- Update the `CHANGELOG.md` in the respective modules directory with details of your change and ensuring your following the correct format.

### Testing Your Changes
- Test your changes thoroughly.

### Committing Your Changes
- Use clear and meaningful commit messages.
- Include descriptions of your changes and reference any relevant issue numbers.

### Submitting a Pull Request (PR)
- Push your changes to your feature branch.
- Submit a pull request to the original repository to the `dev` branch.
- Reference any issues addressed in the PR description.
    - Describe the problem and solution clearly, including relevant issue numbers.

## Code Review Process
- Repository codeowners will review all PRs.
- Reviewers may request changes. Collaborate with them to make necessary adjustments.
- Approved changes will be merged by a codeowners.

## Questions or Need Help?
If you need help or have questions, feel free to reach out to the codeowners or ask in issues related to specific problems.
