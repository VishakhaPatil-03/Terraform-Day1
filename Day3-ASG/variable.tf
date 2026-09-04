variable "aws_region" {
    description = "The AWS region where the resources will be created."
    type        = string
    default     = "ap-southeast-1"
}

variable "aws_ami" {
    description = "The AMI ID to use for the instance"
    type        = string
    default     = "ami-0532913178263be11"
}

variable "instance_type"{
    type = string
    default = "t2.micro"

}

