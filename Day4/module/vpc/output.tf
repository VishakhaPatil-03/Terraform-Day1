output "vpc_id"{
    value = aws_vpc.my-vpc.id
}

output "sg_id"{
    value = aws_security_group.sg.id
}

output "public_subnet_id"{
    value = aws_public_subnet.public-subnet.id
}

output "private_subnet_id" {
    value = aws_private_subnet.private-subnet.id 
}