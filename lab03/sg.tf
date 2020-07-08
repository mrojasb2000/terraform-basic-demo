resource "aws_security_group" "lemontech_backend_security_group_1" {
  name        = "lemontech_backend_security_group_1"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.lemontech_backend_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
      Owner = "Lemontech"
      Name = "Backend Security Group 1"
  }
}

resource "aws_security_group" "lemontech_backend_security_group_2" {
  name        = "lemontech_backend_security_group_2"
  description = "Allow http and https inbound traffic"
  vpc_id      = aws_vpc.lemontech_backend_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
      Owner = "Lemontech"
      Name = "Backend Security Group 2"
  }
}
