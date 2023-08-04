#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/instance
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.cidr_block
  tags = {
   Name = "${var.user_prefix}-${var.vpc_name}"
 }
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/subnet
resource "aws_subnet" "subnet_virginia" {
  vpc_id = aws_vpc.vpc_virginia.id
  cidr_block = "10.0.32.0/20"
  availability_zone = data.aws_availability_zones.azs_virginia.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.user_prefix}-subnetPublic"
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/internet_gateway
resource "aws_internet_gateway" "igw_virginia" {
  vpc_id = aws_vpc.vpc_virginia.id
  tags = {
    Name = "${var.user_prefix}-igw"
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/route_table
resource "aws_route_table" "rt_virginia" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_virginia.id
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/route_table_association
resource "aws_route_table_association" "rta_virginia" {
  subnet_id      = aws_subnet.subnet_virginia.id
  route_table_id = aws_route_table.rt_virginia.id
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/security_group
resource "aws_security_group" "sg_virginia" {
  name        = "${var.user_prefix}-sg"
  description = "Lab SG"
  vpc_id      = aws_vpc.vpc_virginia.id

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
resource "aws_instance" "instance_virginia" {
  ami = data.aws_ssm_parameter.amazon.value
  instance_type = "t3.micro"
  subnet_id              = aws_subnet.subnet_virginia.id
  vpc_security_group_ids = [aws_security_group.sg_virginia.id]
  tags = {
   Name = "${var.user_prefix}-${var.vpc_name}"
 }
}