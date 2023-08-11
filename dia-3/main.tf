data "aws_ssm_parameter" "al2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-ebs"
}

data "aws_availability_zones" "azs" {
  state = "available"
}

module "server1" {
  source             = "./server"
  package_name       = "httpd"
  service_name       = "httpd"
  instance_name      = var.instance_name
  ami                = data.aws_ssm_parameter.al2_ami.value
  subnet_id          = aws_subnet.lab_subnet.id
  security_group_ids = [aws_security_group.lab_sg.id]

  depends_on = [ aws_vpc.lab_vpc ]
}

module "server2" {
  source             = "./server"
  package_name       = "mariab-server"
  service_name       = "mysqld"
  instance_name      = "xjulio-servidor2"
  ami                = data.aws_ssm_parameter.al2_ami.value
  subnet_id          = aws_subnet.lab_subnet.id
  security_group_ids = [aws_security_group.lab_sg.id]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "modulo-vpc"
  cidr = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
