variable "vpc_name" {
  description = "Nome da VPC"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type = string
}

variable "azs" {
  description = "Zonas de disponibilidade"
  type = list(string)
}

variable "enable_nat_gatway" {
  description = "Habilitar NAT Gateway"
  type = bool
  default = false
}

variable "prefix" {
    description = "Prefixo do nome dos recursos"
    type = string
}
