terraform {
  backend "s3" {
    # these values are read during `terraform init` and must exist
    bucket         = var.tfstate_bucket
    key            = "prod/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = var.tfstate_lock_table
    encrypt        = true
  }
}