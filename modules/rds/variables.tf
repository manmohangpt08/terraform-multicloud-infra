variable "name" { type = string }
variable "engine" { type = string }
variable "username" { type = string }
variable "password" { type = string }
variable "instance_class" { type = string }
variable "allocated_storage" { type = number }
variable "multi_az" {
  type    = bool
  default = true
}
variable "subnet_ids" { type = list(string) }
