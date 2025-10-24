# Terraform Multi-cloud scaffold


## Quickstart (dev)


1. cd environments/dev
2. terraform init
3. terraform plan -out plan.tfplan
4. terraform apply plan.tfplan


## Notes
- For prod use S3 backend; set `tfstate_bucket` and lock table.
- Secrets (DB password, provider creds) should be stored in your CI secrets or use a secrets manager.