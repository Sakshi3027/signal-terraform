# Signal Terraform

Infrastructure as Code for the Signal Market Intelligence Platform on GCP.
Provisions a full GKE cluster, VPC networking, Cloud SQL PostgreSQL, and
all supporting resources with reproducible Terraform modules.

## Architecture
GCP Project

├── Networking Module

│   ├── VPC (signal-vpc)

│   ├── Subnet (10.0.0.0/24)

│   └── Firewall rules

├── GKE Module

│   ├── GKE Cluster (signal-dev/prod)

│   └── Node Pool (autoscaling 2-5 nodes)

└── Postgres Module

├── Cloud SQL PostgreSQL 16

├── Private IP (no public exposure)

└── Automated backups at 02:00

## Usage

```bash
cd environments/dev

terraform init
terraform plan
terraform apply
```

## Modules

| Module | Description |
|---|---|
| `modules/networking` | VPC, subnet, firewall rules |
| `modules/gke` | GKE cluster + autoscaling node pool |
| `modules/postgres` | Cloud SQL PostgreSQL with private IP |

## Environments

| Environment | Config |
|---|---|
| `dev` | 2 GKE nodes, db-f1-micro |
| `prod` | 5 GKE nodes, db-custom-2-4096 |

## State management

Remote state stored in GCS bucket `signal-terraform-state` with prefix
`terraform/state` — no local state files, safe for team use.

## Key features

- Modular structure — reuse across dev and prod
- GCS remote state with locking
- Private Cloud SQL (no public IP)
- GKE workload identity enabled
- Node pool autoscaling (2-5 nodes)
- Sensitive variables never committed to git
