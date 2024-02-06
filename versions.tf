terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "viveksharma-tfbackend"
    key    = "KPMG/terraform.tfstate"
    region = "eu-west-1"
  }
}