output "instance_public_ip" {
    value = aws_instance.day1.public_ip
}

output "instance_public_dns" {
    value = aws_instance.day1.public_dns
}

output "security_group_id" {
    value = aws_security_group.sg.id
}

output "key_pair_name" {
    value = aws_instance.day1.key_name
}