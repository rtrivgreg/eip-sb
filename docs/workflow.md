# Workflow

## Manual trigger inputs

The GitHub Actions workflow is intended to expose only two operator inputs:

- `action`
- `vpc_profile`

Expected values:

- `action`: `plan`, `apply`, `destroy`
- `vpc_profile`: `minimal`, `development`, `production`

This keeps the workflow dispatch screen approachable and avoids presenting many low-level networking options.

## Variable passing

The workflow should pass the selected profile into Terraform using an environment variable such as:

```yaml
TF_VAR_vpc_profile: ${{ inputs.vpc_profile }}
```

That pattern keeps the workflow generic and lets Terraform remain the single source of truth for how profiles behave.

## Sequencing behavior

The intended sequencing preserves a plan-first workflow:

- `plan` runs first.
- `apply` depends on a successful `plan`.
- `destroy` depends on a successful `plan`.

This gives operators a review point before making changes to infrastructure and keeps the flow aligned with Terraform best practices.

## Why the workflow stays simple

The workflow should not contain logic such as:

- choosing subnet counts
- enabling NAT
- enabling endpoints
- selecting database subnet behavior

Those decisions belong in Terraform locals. Keeping them out of YAML reduces duplication and makes profile changes much easier to maintain.

## Operational model

The expected operational model looks like this:

- Operators choose intent in GitHub Actions.
- Terraform validates that intent.
- Terraform computes the topology.
- Terraform applies or destroys the resulting infrastructure.

This produces a cleaner interface for repeatable POC deployments and makes it easier to extend the profiles later without redesigning the workflow.
