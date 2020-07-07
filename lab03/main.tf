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
  availability_zone = "us-west-1a"

  tags = {
    Name = "Lemontech Subnet 1"
  }
}

resource "aws_subnet" "lemontech_subnet_2" {
  vpc_id     = aws_vpc.lemontech_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1c"

  tags = {
    Name = "Lemontech Subnet 2"
  }
}

resource "aws_subnet" "lemontech_subnet_3" {
  vpc_id     = aws_vpc.lemontech_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1c"

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
