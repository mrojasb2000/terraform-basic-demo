provider "aws" {
    region = var.region
}

resource "aws_vpc" "lemontech_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "Lemontech VPC"
  }
}

resource "aws_subnet" "lemontech_subnet_1" {
  vpc_id     = aws_vpc.lemontech_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "Lemontech Subnet 1"
  }
}

resource "aws_subnet" "lemontech_subnet_2" {
  vpc_id     = aws_vpc.lemontech_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "Lemontech Subnet 2"
  }
}

resource "aws_subnet" "lemontech_subnet_3" {
  vpc_id     = aws_vpc.lemontech_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1c"

  tags = {
    Name = "Lemontech Subnet 3"
  }
}

resource "aws_internet_gateway" "lemontech_gateway" {
  vpc_id = aws_vpc.lemontech_vpc.id

  tags = {
    Name = "Lemontech Gateway"
  }
}

resource "aws_route_table" "lemontech_route_table" {
  vpc_id = aws_vpc.lemontech_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lemontech_gateway.id
  }

  tags = {
    Name = "lemontech Route Table"
  }
}

resource "aws_route_table_association" "lemontech_route_table_association_1" {
  subnet_id      = aws_subnet.lemontech_subnet_1.id
  route_table_id = aws_route_table.lemontech_route_table.id
}

resource "aws_route_table_association" "lemontech_route_table_association_2" {
  subnet_id      = aws_subnet.lemontech_subnet_2.id
  route_table_id = aws_route_table.lemontech_route_table.id
}

resource "aws_route_table_association" "lemontech_route_table_association_3" {
  subnet_id      = aws_subnet.lemontech_subnet_3.id
  route_table_id = aws_route_table.lemontech_route_table.id
}




/* data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.key_pair.key_name}"
  security_groups = ["${aws_security_group.lemontech_sg.name}"]

  tags = {
    Name = "Lemontch"
  }
}

resource "aws_security_group" "lemontech_sg" {
  name = "lemontech_sg"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # To keep this example simple, we allow incoming SSH requests from any IP. In real-world usage, you should only
    # allow SSH requests from trusted servers, such as a bastion host or VPN server.
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # To keep this example simple, we allow incoming SSH requests from any IP. In real-world usage, you should only
    # allow SSH requests from trusted servers, such as a bastion host or VPN server.
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "key_pair" {
  key_name = "lemontech-key"
  public_key = "${file("./keys/aws-terraform.pub")}" 
} */