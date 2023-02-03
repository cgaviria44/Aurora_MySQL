terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  profile = var.profile
}

terraform {
  backend "s3" {
    bucket = "ingenio-mybackend-tf"
    key    = "rds/dev/terraform.tfstate"
    region = "us-east-1"
    profile = "ingenio"
  }
}