# Architecture

## Overview

This repository implements a profile-driven VPC deployment pattern using GitHub Actions for operator input and Terraform for infrastructure translation.

The key idea is that the CI workflow should capture intent, not topology. The operator chooses a profile such as `minimal`, `development`, or `production`, and Terraform locals derive the detailed network shape from that choice.

## Control flow

The control flow is designed to stay simple:

1. GitHub Actions starts from a manual `workflow_dispatch`.
2. The operator selects:
   - `action`
   - `vpc_profile`
3. The workflow exports `TF_VAR_vpc_profile`.
4. Terraform validates the value.
5. Terraform locals derive a curated VPC configuration.
6. The VPC module and optional endpoint resources are applied using that derived configuration.

This split keeps workflow YAML small and prevents networking logic from spreading across CI and Terraform layers.

## Design principle

The implementation follows a strong separation of concerns:

- GitHub Actions handles orchestration.
- Terraform variables define the supported interface.
- Terraform locals define the opinionated profile mappings.
- Terraform resources and modules implement the infrastructure.

That separation makes the codebase easier to review because profile logic is centralized in one place rather than distributed across shell conditionals or workflow expressions.

## Profile translation model

The expected locals model is a map of profile names to curated settings. From that map, Terraform derives values such as:

- AZ count and selected AZs
- public subnet CIDRs
- private subnet CIDRs
- database subnet CIDRs
- NAT gateway enablement
- single-NAT versus per-AZ NAT strategy
- DNS support and hostnames
- endpoint enablement

This approach makes it clear which infrastructure behavior belongs to each profile.

## Endpoint strategy

The design also allows endpoint behavior to be profile-driven.

Expected behavior:

- `minimal` creates no endpoints.
- `development` enables an S3 gateway endpoint.
- `production` enables an S3 gateway endpoint and may also enable a DynamoDB gateway endpoint.

If endpoints are implemented outside the VPC module, a dedicated file such as `endpoints.tf` keeps them easy to inspect and maintain.

## POC tradeoffs

The repository is intentionally opinionated.

It does not attempt to expose every underlying `terraform-aws-modules/vpc/aws` option. Instead, it provides a small, curated interface that aims to avoid invalid combinations and reduce operator hesitation.

The `production` profile is also intentionally simplified for POC use. It models a multi-tier network with database subnets, but avoids creating an RDS DB subnet group resource.
