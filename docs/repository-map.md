# Repository map

## Overview

This document explains the expected purpose of the key files in the repository.

The implementation centers on a GitHub Actions workflow, Terraform input validation, Terraform locals for profile translation, and Terraform resources for the resulting VPC and endpoint configuration.

## Expected files

### `.github/workflows/terraform-poc.yml`

Manual workflow entry point.

Expected responsibilities:

- expose `action` input
- expose `vpc_profile` input
- pass `TF_VAR_vpc_profile` into Terraform
- preserve plan-before-apply/destroy sequencing

### `poc/variables.tf`

Terraform input interface.

Expected responsibilities:

- define `vpc_profile`
- validate allowed values:
  - `minimal`
  - `development`
  - `production`

### `poc/locals.tf`

Terraform translation layer.

Expected responsibilities:

- define the profile map
- select AZ count
- derive subnet CIDR lists
- derive NAT settings
- derive DNS settings
- derive endpoint flags

This file is the core of the profile-based design.

### `poc/vpc.tf`

Terraform infrastructure layer for the VPC itself.

Expected responsibilities:

- call `terraform-aws-modules/vpc/aws`
- consume derived locals rather than hardcoded topology values
- create a valid subnet and NAT combination for each profile

### `poc/endpoints.tf` or similar

Optional endpoint resource layer.

Expected responsibilities:

- create profile-driven VPC endpoints if managed outside the VPC module
- keep endpoint resources clearly separated and easy to review
- align endpoint behavior with the chosen profile

## Suggested reading order

For understanding the repository quickly, read files in this order:

1. `README.md`
2. `.github/workflows/terraform-poc.yml`
3. `poc/variables.tf`
4. `poc/locals.tf`
5. `poc/vpc.tf`
6. `poc/endpoints.tf` if present

That order mirrors the flow from operator intent to computed topology to infrastructure resources.
