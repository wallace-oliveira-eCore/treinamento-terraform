variable "user_prefix" {
  description = "value to be used as prefix for resources"
  type = string
}

variable "vpc_name" {
    description = "Nomde da Vpc"
    type = string
}

variable "cidr_block" {
    description = "Cidr da vpc"
    type = string
}