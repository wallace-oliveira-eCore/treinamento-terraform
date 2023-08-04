#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs
provider "aws" {
  region = "us-east-1"
}

#https://registry.terraform.io/providers/hashicorp/aws/5.11.0/docs
provider "aws" {
  region = "us-east-2"
  alias = "ohio"
  default_tags {
    tags ={
      criado = var.user_prefix
      IAC = "terraform"
    }
  }
}