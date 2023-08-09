output "instance_id" {
  value = aws_instance.vm1.id
}

# public ip address
output "public_ip" {
  value = aws_instance.vm1.public_ip
}

# public dns
output "public_dns" {
  value = aws_instance.vm1.public_dns
}

# private ip
output "private_ip" {
  value = aws_instance.vm1.private_ip
}
