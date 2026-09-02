terraform {
    required_providers {
        aws = {
            source = "hashicrop/aws"
            version = "~> 6.0"
        }

    }
}

provider "aws" {
    region = "ap-southeast-1"
}

