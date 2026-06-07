# vpce-ec2messages

A proof-of-concept repository that uses GitHub Actions and Terraform to deploy a curated AWS VPC shape based on a small set of operator-friendly profiles.

The design goal is simple: keep the GitHub Actions manual trigger UI easy to use while letting Terraform decide the actual topology. Instead of exposing many low-level networking toggles, the workflow accepts two high-level choices:

- `action = plan | apply | destroy`
- `vpc_profile = minimal | development | production`

Terraform locals translate the selected profile into concrete VPC module inputs such as AZ count, subnet layout, NAT behavior, DNS settings, and optional endpoint creation.

## Purpose

This repository demonstrates a profile-based VPC deployment workflow built around these ideas:

- GitHub Actions collects only operator intent.
- Terraform owns topology translation.
- The implementation remains opinionated and maintainable.
- The POC backend and state path remain isolated from other environments.

The repository also models optional endpoint behavior as part of the selected profile so the CI workflow does not need to know networking details.

## What the profiles do

| Profile | Topology | NAT | Database subnets | Endpoints | Intended use |
|---------|----------|-----|------------------|-----------|--------------|
| `minimal` | 1 AZ, public subnets only | Disabled | No | None | Cheapest and fastest test VPC |
| `development` | 2 AZs, public + private subnets | Single NAT gateway | No | S3 gateway endpoint | Practical day-to-day developer VPC |
| `production` | 3 AZs, public + private + database subnets | Single NAT gateway for POC cost control | Yes, but no DB subnet group resource | S3 gateway endpoint, optional or enabled DynamoDB gateway endpoint | Production-style reference VPC |

## How it works

At a high level, the workflow is:

1. An operator manually runs the GitHub Actions workflow.
2. The operator selects an `action` and `vpc_profile`.
3. GitHub Actions passes `vpc_profile` into Terraform through `TF_VAR_vpc_profile`.
4. Terraform validates the profile value.
5. Terraform locals map that profile to a curated network shape.
6. The VPC module and any endpoint resources are created from those derived values.

This keeps the workflow UI simple and keeps topology logic inside Terraform, where it is easier to test, reason about, and maintain.

## Expected Terraform design

The Terraform implementation is expected to include:

- `poc/variables.tf`  
  Defines `vpc_profile` and validates allowed values.

- `poc/locals.tf`  
  Maps profile names to derived configuration such as:
  - number of AZs
  - selected AZ names
  - public/private/database subnet CIDRs
  - NAT settings
  - DNS settings
  - endpoint enablement

- `poc/vpc.tf`  
  Passes derived values into the `terraform-aws-modules/vpc/aws` module.

- Optional endpoint file such as `poc/endpoints.tf`  
  Creates profile-driven VPC endpoints if they are managed outside the VPC module.

- `.github/workflows/terraform-poc.yml`  
  Exposes the simplified manual inputs and preserves plan-before-apply/destroy sequencing.

## Why this design

This repository intentionally favors readability and operator safety over unlimited configurability.

Benefits of this pattern:

- Fewer workflow inputs.
- Lower chance of invalid infrastructure combinations.
- Easier review of networking behavior.
- Cleaner separation between CI orchestration and infrastructure logic.

Tradeoffs:

- Less flexibility than exposing every raw module variable.
- Profile changes require code updates rather than ad hoc UI overrides.
- The production profile is intentionally simplified for POC use, especially around NAT cost and database subnet group behavior.

## Production profile note

The `production` profile keeps database subnets to model a more realistic multi-tier network but does **not** create an RDS DB subnet group. This avoids extra RDS-specific permissions and API behavior while still preserving the subnet layout for documentation and future extension.

## Running the workflow

From the GitHub Actions manual dispatch screen:

1. Choose `action`:
   - `plan`
   - `apply`
   - `destroy`

2. Choose `vpc_profile`:
   - `minimal`
   - `development`
   - `production`

3. Run the workflow.

The intended sequencing is:

- `apply` depends on a successful `plan`
- `destroy` depends on a successful `plan`

That sequencing helps confirm the selected profile before infrastructure changes are made.

## State isolation

This repository is intended to keep its POC backend configuration and state path isolated from other environments. That makes experimentation safer and reduces the chance of overlapping state operations with unrelated Terraform deployments.

## Repository guide

See the docs directory for deeper explanation:

- `docs/architecture.md` — system design and control flow
- `docs/workflow.md` — GitHub Actions behavior and sequencing
- `docs/profiles.md` — exact profile behavior and tradeoffs
- `docs/repository-map.md` — file-by-file orientation

## Future enhancements

Potential next improvements:

- Add a small architecture diagram.
- Add example `terraform plan` excerpts for each profile.
- Add validation tests for profile-to-topology mappings.
- Add cost notes per profile.
- Optionally add interface endpoints for Systems Manager-related private access scenarios if the repository evolves in that direction.
