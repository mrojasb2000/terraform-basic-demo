resource "aws_instance" "lemontech_server_1" {
    count = length(var.subnet_private_ip)
    ami = var.ami_identificator
    instance_type = var.ami_type
    associate_public_ip_address = var.public_ip_address
    subnet_id = aws_subnet.lemontech_subnet_1.id
    vpc_security_group_ids = ["${aws_security_group.lemontech_security_group_1.id}", "${aws_security_group.lemontech_security_group_2.id}"]
    private_ip = element(var.subnet_private_ip, count.index)
    key_name = aws_key_pair.lemontech_key_pair.id
    user_data = file("userdata.sh")

    tags = {
      "Name" = "Lemontech Instance ${count.index + 1}"
      Owner = "Lemontech ${count.index + 1}"
    }
}