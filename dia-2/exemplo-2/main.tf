terraform {
  required_version = ">=1.5"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs
provider "aws" {
  region = "us-east-2"
  alias = "oregon"
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/data-resources/ami
data "aws_ami" "amazon" {
  most_recent = true
 owners = ["amazon"]
  filter {
    name = "architecture"
    values = ["arm64"]
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/instance
resource "aws_instance" "instanceWallaceOregon" {
  ami = data.aws_ami.amazon.id
  instance_type = "t4g.nano"

}

# https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/data-sources/ssm_parameter
data "aws_ssm_parameter" "amazon" {
    name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-minimal-hvm-x86_64-ebs"
    provider = aws.oregon
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs/resources/instance
resource "aws_instance" "instanceWallace" {
    provider = aws.oregon
  ami = data.aws_ssm_parameter.amazon.value
  instance_type = "t3.micro"
}