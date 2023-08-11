variable "instance_type" {
  description = "Tipo da instância"
  type        = string
}

variable "instance_ami" {
  description = "AMI da instância"
  type        = string
}

variable "instance_key_name" {
  description = "Chave da instância"
  type        = string
}

variable "prefix" {
  description = "Prefixo do nome dos recursos"
  type        = string
}

variable "web_server_ingres_ports" {
  description = "Portas de entrada para o servidor web"
  type        = list(number)
  default     = [80, 22, 443]
}

variable "db_server_ingres_ports" {
  description = "Portas de entrada para o servidor db"
  type        = list(number)
  default     = [3306, 22]
}
