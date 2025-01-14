# get lastest ami from ssm parameter store
data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# get subnet id from remote s3 backend
data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket  = "terraform-state-xjulio"
    key     = "dev/infraestrutura.tfstate"
    region  = "us-east-1"
    profile = "admin-2023"
  }
}

locals {
  public_subnets_ids  = data.terraform_remote_state.infra.outputs.public_subnets_ids
  private_subnets_ids = data.terraform_remote_state.infra.outputs.private_subnets_ids
  vpc_id              = data.terraform_remote_state.infra.outputs.vpc_id
  vpc_cidr            = data.terraform_remote_state.infra.outputs.vpc_cidr
}

module "webserver" {
  source = "git@github.com:xjulio/terraform-aws-servidor-lab.git"

  instance_name     = "${var.prefix}-servidor-web"
  instance_ami      = data.aws_ssm_parameter.ami.value
  instance_type     = var.instance_type
  instance_key_name = var.instance_key_name

  subnet_id         = local.private_subnets_ids[0]
  security_group_id = aws_security_group.web.id

  package_name = "httpd"
  service_name = "httpd"
}

module "webserver1" {
  source = "git@github.com:xjulio/terraform-aws-servidor-lab.git"

  instance_name     = "${var.prefix}-servidor-web1"
  instance_ami      = data.aws_ssm_parameter.ami.value
  instance_type     = var.instance_type
  instance_key_name = var.instance_key_name

  subnet_id         = local.public_subnets_ids[0]
  security_group_id = aws_security_group.web.id

  package_name = "httpd"
  service_name = "httpd"
}

module "database" {
  source = "git@github.com:xjulio/terraform-aws-servidor-lab.git"

  instance_name     = "${var.prefix}-servidor-db"
  instance_ami      = data.aws_ssm_parameter.ami.value
  instance_type     = var.instance_type
  instance_key_name = var.instance_key_name

  subnet_id         = local.private_subnets_ids[1]
  security_group_id = aws_security_group.db.id

  package_name = "httpd"
  service_name = "httpd"
}

resource "aws_security_group" "web" {
  name   = "${var.prefix}-sg-web-1"
  vpc_id = local.vpc_id

  description = "Security group para instancias web"

  dynamic "ingress" {
    for_each = var.web_server_ingres_ports

    content {
      description = "Permitem trafego de entrada na porta ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # permite tráfego de saída para qualquer destino
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "db" {
  name   = "${var.prefix}-sg-db"
  vpc_id = local.vpc_id

  description = "Security group para instancias db"

  dynamic "ingress" {
    for_each = var.db_server_ingres_ports

    content {
      description = "Permitem trafego de entrada na porta ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # permite tráfego de saída para qualquer destino
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.7.0"

  name               = "lb1"
  load_balancer_type = "application"

  vpc_id          = local.vpc_id
  subnets         = local.public_subnets_ids
  security_groups = [aws_security_group.web.id]

  target_groups = [
    {
      name_prefix      = "tg-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        web1 = {
          target_id = module.webserver.instance_id
          port      = 80
        }
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}
