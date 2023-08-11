variable "ami" {
    description = "AMI to be used by the instance"
    type        = string
}

variable "instance_type" {
    description = "Type of the instance"
    type        = string
    default     = "t2.micro"
}

variable "subnet_id" {
    description = "ID of the subnet where the instance will be created"
    type        = string
}

variable "security_group_ids" {
    description = "ID of the security group to be used by the instance"
    type        = set(any)
}

variable "welcome_msg" {
    description = "Content of the http index page"
    type        = string
    default = "Gerado utilizando modulo terraform"
}

variable "instance_name" {
    description = "Tag Name of the instance"
    type        = string
}

variable "service_name" {
    description = "Name of the service to be installed"
    type        = string
}

variable "package_name" {
    description = "Name of the package to be installed"
    type        = string
}

