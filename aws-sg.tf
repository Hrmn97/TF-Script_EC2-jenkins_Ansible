resource "aws_security_group" "default-sg" {
  name        = "security_grp"
  description = "Allowing basic security"

  dynamic "ingress" {
    for_each = [22, 80, 443, 8080]
    iterator = port
    content {
      description = "Inbound rules required only"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ingress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "default_sg"
  }
}
