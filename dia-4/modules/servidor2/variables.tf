variable "instance_name" {
  description = "Nome da instância"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância"
  type        = string
  default     = "t2.micro"
}

variable "instance_ami" {
  description = "AMI da instância"
  type        = string
}

variable "instance_key_name" {
  description = "Chave da instância"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "package_name" {
  description = "Nome do pacote"
  type        = string
}

variable "service_name" {
  description = "Nome do serviço"
  type        = string
}
