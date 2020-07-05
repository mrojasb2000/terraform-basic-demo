resource "aws_instance" "lemontech_server_1" {
    ami = "ami-${var.ami_identificator}"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.lemontech_subnet_1.id
    vpc_security_group_ids = ["${aws_security_group.lemontech_security_group_1.id}", "${aws_security_group.lemontech_security_group_2.id}"]
    private_ip = "10.0.1.50"
    key_name = aws_key_pair.lemontech_key_pair.id

    tags = {
      "Name" = "Lemontech Instance 1"
      Owner = "Lemontech"
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
