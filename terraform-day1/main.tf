resource "aws_instance" "day1" {
    ami = var.aws_ami
    instance_type = var.instance_type
    user_data = file("/home/ubuntu/Terraform-Day1/user.sh")
    vpc_security_group_ids = [aws_security_group.sg.id]

    key_name = "kapishh"

    tags ={

        Name = "Day1_terraform"
    }
}

resource "aws_security_group" "sg" {
    name = "day1_sg"
    description = "Security group for day1 instance"
   
   ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
    tags = {
        Name = "day1_sg"
    }
}
