variable "name" { type = string }
variable "ami" { type = string }
variable "instance_type" { type = string }
variable "subnet_ids" { type = list(string) }
variable "vpc_id" { type = string }
variable "bastion" { type = bool, default = false }