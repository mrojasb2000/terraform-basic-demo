resource "aws_instance" "lemontech_server_1" {
    ami = "ami-${var.ami_identificator}"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.lemontech_subnet_1.id
    associate_public_ip_address = true

    tags = {
      "Name" = "Lemontech Instance 1"
    }
}

output "aws_instance_ami_id" {
    value = aws_instance.lemontech_server_1.id
}

output "aws_instance_ami_instance_type" {
    value = aws_instance.lemontech_server_1.instance_type
}

output "aws_instance_public_ip_address" {
    value = aws_instance.lemontech_server_1.associate_public_ip_address
}

output "aws_instance_subnet_id" {
    value = aws_subnet.lemontech_subnet_1.id
}