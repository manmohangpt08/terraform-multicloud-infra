variable "name" {}
variable "ami" { type = string }
variable "instance_type" { type = string }
variable "subnet_ids" { type = list(string) }
variable "bastion" { type = bool }


resource "aws_security_group" "app_sg" {
name = "${var.name}-sg"
description = "Allow app traffic (example: 22 from bastion, 80/443 from ALB)"
vpc_id = var.vpc_id
}


resource "aws_instance" "this" {
count = var.bastion ? 1 : 2
ami = var.ami
instance_type = var.instance_type
subnet_id = element(var.subnet_ids, count.index)
vpc_security_group_ids = [aws_security_group.app_sg.id]
tags = { Name = "${var.name}-instance-${count.index}" }
}


output "instance_ids" { value = aws_instance.this[*].id }