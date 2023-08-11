# define instance
resource "aws_instance" "server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  user_data = templatefile("${path.module}/scripts/userdata.sh", {
    PACKAGE_NAME = var.package_name
    SERVICE_NAME = var.service_name
  })

  tags = {
    Name = var.instance_name
  }

  # recrates instance if user data script changes
  user_data_replace_on_change = true
}
