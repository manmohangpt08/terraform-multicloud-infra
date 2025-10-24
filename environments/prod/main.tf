# Prod environment using the modules in ../..
terraform {
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
  # Credentials: Prefer IAM role for the runner (e.g., GitHub Actions) or environment variables.
}

# ===== VPC =====
module "vpc" {
  source               = "../../modules/vpc"
  name                 = "prod-app"
  cidr                 = "10.1.0.0/16"
  azs                  = ["${var.aws_region}a", "${var.aws_region}b"] # example; ensure these AZ names are valid for your region
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.10.0/24", "10.1.11.0/24"]
  env                  = var.env
  provider             = "aws"
}

# ===== EC2 (bastion + app servers) =====
module "bastion" {
  source        = "../../modules/ec2"
  name          = "bastion"
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_ids    = module.vpc.public_subnet_ids
  vpc_id        = module.vpc.vpc_id
  bastion       = true
}

module "app" {
  source        = "../../modules/ec2"
  name          = "app"
  ami           = var.ami
  instance_type = var.instance_type
  subnet_ids    = module.vpc.private_subnet_ids
  vpc_id        = module.vpc.vpc_id
  bastion       = false
}

# ===== RDS Postgres (multi-AZ) =====
module "rds" {
  source            = "../../modules/rds"
  name              = "prod-appdb"
  engine            = "postgres"
  username          = var.db_username
  password          = var.db_password
  instance_class    = "db.t3.medium"
  allocated_storage = 100
  multi_az          = true
  subnet_ids        = module.vpc.private_subnet_ids
}

# Optional outputs exported from modules
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "app_instance_ids" {
  value = module.app.instance_ids
}

output "bastion_public_ip" {
  value = module.bastion.instance_ids
}

output "rds_endpoint" {
  value = module.rds.endpoint
}
