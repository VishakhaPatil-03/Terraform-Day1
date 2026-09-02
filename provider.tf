terraform {
    required_providers {
        aws = {
            source = "hashicrop/aws"
           version = "~> 5.0" 
        }

    }
}

provider "aws" {
    region = "ap-southeast-1"
}

