# define instance
resource "aws_instance" "vm1" {
  ami                    = data.aws_ssm_parameter.al2_ami.value
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.lab_subnet.id
  vpc_security_group_ids = [aws_security_group.lab_sg.id]
  tags = {
    Name = "${var.prefix}-${var.instance_name}"
  }
}
