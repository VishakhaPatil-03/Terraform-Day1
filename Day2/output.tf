output "aws_instance_id" {
  value = aws_instance.my_ec2.id
}

output "aws_instance_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

output "aws_instance_private_ip" {
  value = aws_instance.my_ec2.private_ip
}   

output "aws_instance_public_dns" {
  value = aws_instance.my_ec2.public_dns
}

output "aws_instance_private_dns" {
  value = aws_instance.my_ec2.private_dns
}


output "aws_sg_id" {
  value = aws_security_group.sg.id
}       

