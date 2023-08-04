#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/data-sources/availability_zones
data "aws_availability_zones" "azs_virginia" {
  state = "available"
}

# https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/data-sources/ssm_parameter
data "aws_ssm_parameter" "amazon" {
    name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-minimal-hvm-x86_64-ebs"
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/data-resources/ami
data "aws_ami" "amazon" {
  most_recent = true
 owners = ["amazon"]
  filter {
    name = "architecture"
    values = ["arm64"]
  }
  provider = aws.ohio
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/data-sources/availability_zones
data "aws_availability_zones" "azs_ohio" {
  provider = aws.ohio
  state = "available"
}
