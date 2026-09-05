variable  "aws_ami" {
    description = "The AMI ID to use for the instance"
    type = string
    default = "ami-0532913178263be11"
    
}
variable "instance_type" {
    description = " this was the my instance type"
    type = string
    default = "t2.micro"
}

