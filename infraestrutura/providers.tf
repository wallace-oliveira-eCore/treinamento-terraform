terraform {
  backend "s3" {
    bucket  = "terraform-state-xjulio"
    key     = "dev/infraestrutura.tfstate"
    region  = "us-east-1"
    profile = "admin-2023"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.11.0"
    }
  }
  required_version = "> 1.5"
}

provider "aws" {
  region  = "us-east-1"
  profile = "admin-2023"

  default_tags {
    tags = {
      Owner       = "xjulio"
      Environment = "dev"
      Managed-by  = "Terraform"
    }
  }
}
