resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name}-vpc"
    Env  = var.env
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.this.idvariable "name" {}
variable "cidr" { type = string }
variable "azs" { type = list(string) }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }


resource "aws_vpc" "this" {
count = var.provider == "aws" ? 1 : 0
cidr_block = var.cidr
enable_dns_hostnames = true
tags = {
Name = "${var.name}-vpc"
Env = var.env
}
}


# Create subnets (public + private) for aws. For azure a separate azurerm resources can be added.
resource "aws_subnet" "public" {
count = length(var.public_subnet_cidrs)
vpc_id = aws_vpc.this[0].id
cidr_block = var.public_subnet_cidrs[count.index]
availability_zone = var.azs[count.index]
map_public_ip_on_launch = true
tags = { Name = "${var.name}-public-${count.index}" }
}


resource "aws_subnet" "private" {
count = length(var.private_subnet_cidrs)
vpc_id = aws_vpc.this[0].id
cidr_block = var.private_subnet_cidrs[count.index]
availability_zone = var.azs[count.index]
tags = { Name = "${var.name}-private-${count.index}" }
}


output "vpc_id" {
value = aws_vpc.this[0].id
description = "VPC id (AWS)"
}


output "public_subnet_ids" {
value = aws_subnet.public[*].id
}


output "private_subnet_ids" {
value = aws_subnet.private[*].id
}
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = { Name = "${var.name}-public-${count.index}" }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = { Name = "${var.name}-private-${count.index}" }
}
