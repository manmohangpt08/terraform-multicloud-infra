variable "cloud" {
description = "Cloud provider to target: aws | azure | local"
type = string
default = "aws"
}


variable "env" {
description = "Environment name (dev|prod)"
type = string
default = "dev"
}