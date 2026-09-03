resource "aws_vpc" "custom_vpc" {
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        name = "my_vpc"
    }

}
 resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.private_subnet.id
    tags = {
        name = "my_nat_gateway"
    }
 }

 resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.custom_vpc.id
    tags = {
        name = "my_igw"
    }
 }

 resource "aws_eip" "nat_eip" {
    domain = "vpc"
    depends_on = [aws_internet_gateway.igw]
    tags = {
        name = "my_nat_eip"
    }
 }

 resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.public_subnet_az
    map_public_ip_on_launch = true
        tags = {
        name = "my_public_subnet"
    }
 }

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.private_subnet_az
    map_public_ip_on_launch = true
    tags = {
        name = "my_private_subnet"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.custom_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
}
tags = {
        name = "my_public_route_table"
    }
}

resource "aws_route_table_association" "public_subnet_assoc" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_assoc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.public_rt.id
}


resource "aws_security_group" "sg" {
    name = "day2_sg"
    description = "Security group for day2 instance"
    vpc_id = aws_vpc.custom_vpc.id
   
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
    from_port =443
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
}

resource "aws_instance" "my_ec2" {
    ami = var.aws_ami
    instance_type = var.instance_type
    user_data = file("/home/ubuntu/Terraform-Day1/user.sh")
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.public_subnet.id
    key_name = "kapishh"

    tags ={
        Name = "Day2_terraform"
    }
}