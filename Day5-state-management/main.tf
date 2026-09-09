resource "aws_instance" "public_instance"{
    ami = "ami-0532913178263be11"
    instance_type = "t3.micro"
    count = 2
    key_name = "kapishh"
    vpc_security_group_ids = [sg-0d2f102537b2190d2]
    tags = {
      Name = "public_instance"
    }
}