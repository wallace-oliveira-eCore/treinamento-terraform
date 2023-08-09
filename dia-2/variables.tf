variable "prefix" {
  description = "value to be used as prefix for resources"
  type        = string
}

variable "vpc_name" {
  description = "Nome do tag Name do VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR do VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_name" {
  description = "Nome do tag Name da instância"
  type        = string
}

variable "welcome_msg" {
  description = "Mensagem de boas vindas"
  type        = string
}
