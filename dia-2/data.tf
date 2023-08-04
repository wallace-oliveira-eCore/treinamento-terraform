data "aws_ssm_parameter" "al2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-ebs"
}

data "aws_availability_zones" "azs" {
  state = "available"
}
