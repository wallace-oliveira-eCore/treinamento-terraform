# define vpc
resource "aws_vpc" "lab_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.prefix}-${var.vpc_name}"
  }
}

# define subnet
resource "aws_subnet" "lab_subnet" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "192.168.0.0/24"
  availability_zone       = data.aws_availability_zones.azs.names[0]
  map_public_ip_on_launch = true
}

# define internet gateway
resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "${var.prefix}-lab-igw"
  }
}

# define route table to internet
resource "aws_route_table" "lab_route_table" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_igw.id
  }
}

# associate route table to subnet
resource "aws_route_table_association" "lab_route_table_association" {
  subnet_id      = aws_subnet.lab_subnet.id
  route_table_id = aws_route_table.lab_route_table.id
}

# define security group
resource "aws_security_group" "lab_sg" {
  name        = "${var.prefix}-lab_sg"
  description = "Lab SG"
  vpc_id      = aws_vpc.lab_vpc.id
  ingress {
    description = "Allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
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
