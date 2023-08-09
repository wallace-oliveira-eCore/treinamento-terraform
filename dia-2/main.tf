data "aws_ssm_parameter" "al2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-ebs"
}

data "aws_availability_zones" "azs" {
  state = "available"
}

# define instance
resource "aws_instance" "vm1" {
  ami                    = data.aws_ssm_parameter.al2_ami.value
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.lab_subnet.id
  vpc_security_group_ids = [aws_security_group.lab_sg.id]

  user_data = templatefile("${path.module}/scripts/userdata.sh", {
    WELCOME_MSG = var.welcome_msg
  })

  tags = {
    Name = "${var.prefix}-${var.instance_name}"
  }

  # recrates instance if user data script changes
  user_data_replace_on_change = true
}
