variable "aws_region" {
  description = "The AWS region where the resources will be created."
  type        = string
  default     = "ap-southeast-1"
}

variable "availability_zone" {
  description = "The AWS availability zone where the resources will be created."
  type        = string
  default     = "ap-southeast-1a"
}   
variable "vpc1_cidr"{               //vpc1 cidr block
    description = "The CIDR block for the first VPC."
    type        = string
    default     = "10.0.0.0/16"
}
variable "vpc2_cidr"{               //vpc2 cidr block
    description = "The CIDR block for the second VPC."
    type        = string
    default     =   "20.0.0.0/16"
}

variable "vpc1_subnet_cidr" {
  description = "Subnet CIDR for VPC 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vpc2_subnet_cidr" {
  description = "Subnet CIDR for VPC 2"
  type        = string
  default     = "20.0.1.0/24"
}