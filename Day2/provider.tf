terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Keeps configuration locked to major version 6
    }
  }
}

# 2. Configure the AWS Provider block
provider "aws" {
  region = "ap-southeast-1"
}