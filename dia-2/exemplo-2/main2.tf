#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/instance
resource "aws_vpc" "vpc_ohio" {
  provider = aws.ohio
  cidr_block = var.cidr_block
  tags = {
   Name = "${var.user_prefix}-${var.vpc_name}"
 }
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/subnet
resource "aws_subnet" "subnet_ohio" {
  provider = aws.ohio
  vpc_id = aws_vpc.vpc_ohio.id
  cidr_block = cidrsubnet(var.cidr_block, 4, 2)
  availability_zone = data.aws_availability_zones.azs_ohio.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.user_prefix}-subnetPublic"
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/internet_gateway
resource "aws_internet_gateway" "igw_ohio" {
  provider = aws.ohio
  vpc_id = aws_vpc.vpc_ohio.id
  tags = {
    Name = "${var.user_prefix}-igw"
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/route_table
resource "aws_route_table" "rt_ohio" {
  provider = aws.ohio
  vpc_id = aws_vpc.vpc_ohio.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_ohio.id
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/route_table_association
resource "aws_route_table_association" "rta_ohio" {
  provider = aws.ohio
  subnet_id      = aws_subnet.subnet_ohio.id
  route_table_id = aws_route_table.rt_ohio.id
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/security_group
resource "aws_security_group" "sg_ohio" {
  provider = aws.ohio
  name        = "${var.user_prefix}-sg"
  description = "Lab SG"
  vpc_id      = aws_vpc.vpc_ohio.id

  ingress {
    description = "Allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/instance
resource "aws_instance" "instance_ohio" {
  provider = aws.ohio
  ami = data.aws_ami.amazon.id
  instance_type = "t4g.micro"
  subnet_id              = aws_subnet.subnet_ohio.id
  vpc_security_group_ids = [aws_security_group.sg_ohio.id]
  tags = {
   Name = "${var.user_prefix}-${var.vpc_name}"
 }
}
