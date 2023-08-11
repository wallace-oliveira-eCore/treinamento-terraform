output "public_ip" {
  value = aws_instance.server.public_ip
}

output "public_dns" {
  value = aws_instance.server.public_dns
}

output "private_ip" {
  value = aws_instance.server.private_ip
}


