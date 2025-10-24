variable "env" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "aws_region" {
  description = "AWS region for prod"
  type        = string
  default     = "us-east-1"
}

variable "tfstate_bucket" {
  description = "S3 bucket for terraform state (must exist)"
  type        = string
  default     = ""
}

variable "tfstate_lock_table" {
  description = "DynamoDB table name for state locking (must exist)"
  type        = string
  default     = ""
}

variable "ami" {
  description = "AMI for EC2 instances"
  type        = string
  default     = "ami-0c94855ba95c71c99" # replace with prod AMI
}

variable "db_username" {
  description = "RDS master username - recommend set via TFVARS or CI secrets"
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "RDS master password - recommend set via TFVARS or CI secrets"
  type        = string
  sensitive   = true
  default     = ""
}

variable "vpc_cidr" {
  description = "VPC CIDR for prod"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet cidrs (list)"
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet cidrs (list)"
  type        = list(string)
  default     = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
}

# Add any other prod-specific variables you need (instance sizes, db sizes, tags)
