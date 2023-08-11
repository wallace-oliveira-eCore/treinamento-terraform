module "lab_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs = var.azs

  enable_nat_gateway = true
  enable_vpn_gateway = false

  map_public_ip_on_launch = true

  public_subnets = cidrsubnets(var.vpc_cidr, 8, 8, 8)
  private_subnets = [
    cidrsubnet(var.vpc_cidr, 8, 100),
    cidrsubnet(var.vpc_cidr, 8, 101),
    cidrsubnet(var.vpc_cidr, 8, 102)
  ]

  tags = {
    Name = "${var.prefix}-${var.vpc_name}"
  }
}
