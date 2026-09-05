output "public_ip"{
    value = aws_instance.public_instance.public_ip.id

}

output "private_ip"{
    value = aws_instance.private_instance.private_ip.id
}

output "public_ip_DNS"{
    value = aws_instance.public_instance.public_dns.id
}