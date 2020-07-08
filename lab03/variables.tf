variable "region" {
    description = "AWS Region"
}

variable "vpc_cidr_block" {
    description = "VPC cidr block"
}

variable "ami_identificator" {
    type = string
    description = "Amazon Machine Image identificator"
}

variable "ami_type" {
    type = string
    description = "Amazon Machine Image Type"
}

variable "public_ip_address" {
    type = bool
    description = "Association public ip address"
    default = false
}

variable "subnet_private_ip" {
    description = "Subnet private ip address list"
    type = list(string)
    default = ["10.0.2.15","10.0.2.25","10.0.2.35"]
}

