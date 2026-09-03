variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    type = string
    default = "10.0.1.0/24"
}

variable "public_subnet_az" {
    type = string
    default = "ap-southeast-1a"
}

variable "private_subnet_cidr" {
    type = string
    default = "10.0.10.0/24"
}

variable "private_subnet_az" {
    type = string
    default = "ap-southeast-1b"
}

variable "aws_ami" {
    type = string
    default = "ami-0532913178263be11"
}
variable "instance_type" {
    type = string
    default = "t3.micro"
}   