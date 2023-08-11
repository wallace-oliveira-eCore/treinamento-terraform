resource "aws_instance" "servidor" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  key_name               = var.instance_key_name
  vpc_security_group_ids = [var.security_group_id]

  user_data = templatefile("${path.module}/userdata.sh", {
    PACKAGE = var.package_name
    SERVICE = var.service_name
  })

  tags = {
    Name = var.instance_name
  }
}
