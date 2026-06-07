# Profiles

## Overview

The repository uses three opinionated VPC profiles. Each profile represents a curated infrastructure shape rather than a collection of independent booleans.

That design reduces decision fatigue and prevents broken combinations such as enabling NAT without the required public subnet structure.

## Profile matrix

| Profile | AZs | Public subnets | Private subnets | Database subnets | NAT | DNS support | DNS hostnames | Endpoints |
|---------|-----|----------------|-----------------|------------------|-----|-------------|---------------|-----------|
| `minimal` | 1 | Yes | No | No | No | Optional/minimal | Optional/minimal | None |
| `development` | 2 | Yes | Yes | No | Single NAT gateway | Enabled | Enabled | S3 gateway endpoint |
| `production` | 3 | Yes | Yes | Yes | Single NAT gateway for this POC | Enabled | Enabled | S3 gateway endpoint, optional or enabled DynamoDB gateway endpoint |

## minimal

The `minimal` profile is the cheapest and fastest profile.

Expected characteristics:

- 1 Availability Zone
- public subnets only
- no NAT gateway
- no database subnets
- no VPC endpoints

This profile is useful for rapid testing of basic VPC creation and simple public-subnet scenarios.

## development

The `development` profile is intended to represent a practical developer VPC.

Expected characteristics:

- 2 Availability Zones
- public and private subnets
- a single NAT gateway
- DNS support enabled
- DNS hostnames enabled
- S3 gateway endpoint enabled

This profile balances realism with cost control and is a good default for everyday testing.

## production

The `production` profile is a production-style reference shape, simplified for POC use.

Expected characteristics:

- 3 Availability Zones
- public, private, and database subnets
- single NAT gateway for cost control in this POC
- DNS support enabled
- DNS hostnames enabled
- S3 gateway endpoint enabled
- DynamoDB gateway endpoint optional or enabled by default if implemented cleanly

Important note:

- database subnets are present
- no RDS DB subnet group is created

That choice preserves the topology without introducing RDS-specific provisioning behavior.

## Tradeoffs

The profile model intentionally gives up some flexibility.

Benefits:

- simpler workflow UI
- fewer invalid combinations
- easier reasoning about infrastructure behavior
- more consistent operator experience

Costs:

- less granular customization
- profile edits require code changes
- some teams may eventually want more profiles or environment-specific overrides
