# aws-tier-observability

A modular, multi-tier cloud architecture on AWS, defined entirely in Terraform and deployed through a GitHub Actions CI/CD pipeline, with built-in monitoring and observability.

## Project Objective

Build and deploy a multi-tier AWS environment using reusable Terraform modules, fully automated through GitHub Actions, with CloudWatch logging and alarms integrated from the start.

## Architecture

| Layer | Module | Description |
|-------|--------|-------------|
| Networking | `modules/vpc` | VPC, public and private subnets, spread across availability zones |
| Compute | `modules/ecs` | Amazon ECS cluster, task definitions and services running containerized workloads |
| Database | `modules/rds` | Relational database instance placed securely in private subnets |
| Security | `modules/security_groups` | Security groups controlling inbound and outbound traffic for the ALB and application tier |
| Observability | `modules/observability` | CloudWatch log groups for container stdout/stderr and metric alarms on ECS CPU utilization |

### State Management

- Remote backend: S3 bucket `aws-tier-observability-tfstate-njambi`
- State locking: DynamoDB table `aws-tier-observability-locks`

## Repository Structure

```
.
├── .github/workflows/   # GitHub Actions pipeline (deploy.yml)
├── modules/
│   ├── vpc/
│   ├── ecs/
│   ├── rds/
│   ├── security_groups/
│   └── observability/
├── backend.tf           # S3 remote state and DynamoDB locking
├── main.tf              # Root module wiring
├── outputs.tf
├── providers.tf
└── variables.tf
```

## CI/CD Pipeline

The `deploy.yml` workflow authenticates to AWS using the official `aws-actions/configure-aws-credentials` action, with access keys stored as GitHub repository secrets, then runs `terraform init`, `plan` and `apply`.

## Technical Challenges and How I Solved Them

### 1. Authentication and credential errors in CI/CD

- **Problem:** The GitHub Actions pipeline failed at the authentication step.
- **Resolution:** Added the `aws-actions/configure-aws-credentials` action to `deploy.yml`, linked to AWS access keys stored as repository secrets.

### 2. Stale remote state locks in DynamoDB

- **Problem:** Crashed or timed-out pipeline runs left lock entries in the `aws-tier-observability-locks` table, causing `ConditionalCheckFailedException` errors during `terraform plan`.
- **Resolution:** Removed the stale lock records directly from the DynamoDB table to release the state file.

### 3. `AccessDenied` IAM permission blockers

- **Problem:** The deployment user (`ian-s3-deployer`) only had access to S3 and DynamoDB, so `terraform plan` failed when querying VPCs, ECS clusters, IAM roles and CloudWatch.
- **Resolution:** Attached the `AdministratorAccess` managed policy to the user to get the pipeline working.
- **Follow-up:** This is broader than necessary. A future improvement is replacing it with a least-privilege policy scoped to the services this project uses.

### 4. Git push rejections from large local files

- **Problem:** Pushes failed with `GH001: Large files detected` because local state files (`errored.tfstate`) and provider binaries in `.terraform/` were tracked by Git.
- **Resolution:** Untracked them with `git rm --cached` and `git rm -r --cached .terraform/`, and updated `.gitignore` to exclude local state files and plugin directories.

## Future Improvements

- Replace static AWS access keys with GitHub OIDC role assumption
- Scope the deployer IAM policy to least privilege
- Add alarms for memory utilization, ALB 5xx errors and RDS metrics
- Add a CloudWatch dashboard and SNS notifications for alarms

## Prerequisites

- Terraform 1.x
- An AWS account with the S3 state bucket and DynamoDB lock table created
- GitHub repository secrets for the AWS access key ID and secret access key