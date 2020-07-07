resource "aws_security_group" "lemontech_security_group_1" {
  name        = "lemontech_security_group_1"
  description = "Allow ssh and ping inbound traffic"
  vpc_id      = aws_vpc.lemontech_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
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
      Name = "Lemontech Security Group 1"
  }
}

resource "aws_security_group" "lemontech_security_group_2" {
  name        = "lemontech_security_group_2"
  description = "Allow http and https inbound traffic"
  vpc_id      = aws_vpc.lemontech_vpc.id

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
      Name = "Lemontech Security Group 2"
  }
}

resource "aws_security_group" "lemontech_db_security_group" {
  name        = "lemontech_db_security_group"
  description = "Allow Mysql, Redis, PhpMyAdmin inbound traffic"
  vpc_id      = aws_vpc.lemontech_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic
  }

  ingress {
    from_port   = 7000
    to_port     = 7000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic
  }

  /* ingress {
    from_port   = 16379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic
  } */

  # Allow outgoing traffic to anywhere
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
      Name = "Lemontech Security Group 2"
  }
}