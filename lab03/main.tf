provider "aws" {
    region = var.region
}

resource "aws_vpc" "lemontech_backend_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "Lemontech VPC"
  }
}

resource "aws_subnet" "lemontech_backend_subnet_1" {
  vpc_id     = aws_vpc.lemontech_backend_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1a"

  tags = {
    Owner = "Lemontech"
    Name = "Backend Subnet 1"
  }
}

resource "aws_internet_gateway" "lemontech_backend_gateway" {
  vpc_id = aws_vpc.lemontech_backend_vpc.id

  tags = {
    Owner = "Lemontech"
    Name = "Backend Gateway"
  }
}

resource "aws_route_table" "lemontech_backend_route_table" {
  vpc_id = aws_vpc.lemontech_backend_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lemontech_backend_gateway.id
  }

  tags = {
    Owner = "Lemontech"
    Name = "Backend Route Table"
  }
}

resource "aws_route_table_association" "lemontech_route_table_association_1" {
  subnet_id      = aws_subnet.lemontech_backend_subnet_1.id
  route_table_id = aws_route_table.lemontech_backend_route_table.id
}
