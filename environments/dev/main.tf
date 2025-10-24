# Dev environment - local backend
terraform {
  required_version = ">= 1.3.0"
}


provider "aws" {
  region = var.aws_region
  # credentials read from env or shared config
}


module "vpc" {
  source               = "../../modules/vpc"
  name                 = "dev-app"
  cidr                 = "10.0.0.0/16"
  azs                  = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  env                  = var.env
  provider             = "aws"
}


module "ec2" {
  source        = "../../modules/ec2"
  name          = "app"
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_ids    = module.vpc.private_subnet_ids
  vpc_id        = module.vpc.vpc_id
}


module "rds" {
  source     = "../../modules/rds"
  name       = "appdb"
  username   = var.db_username
  password   = var.db_password
  subnet_ids = module.vpc.private_subnet_ids
}