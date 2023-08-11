output "instance_id" {
  value = aws_instance.servidor.id
}

output "public_ip" {
  value = aws_instance.servidor.public_ip
}

output "public_dns" {
  value = aws_instance.servidor.public_dns
}

output "private_ip" {
  value = aws_instance.servidor.private_ip
}

output "private_dns" {
  value = aws_instance.servidor.private_dns
}
