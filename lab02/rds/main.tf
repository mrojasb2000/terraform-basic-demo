provider "aws" {
  region = "us-west-1"
}

variable "cluster_name" {
  default = "rds-sample-cluster"
} 
  
variable "instance_class" {
  default = "db.t2.small"
}

variable "username" {
  default = "master"
}

variable "password" {
  default = "password"
}

# =============
# = RDS Setup =
# =============

resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier         = "${var.cluster_name}-instance"
  cluster_identifier = "${aws_rds_cluster.cluster.id}"
  instance_class     = "${var.instance_class}"
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier     = "${var.cluster_name}"
  database_name          = "sample_rds"
  master_username        = "${var.username}"
  master_password        = "${var.password}"
  vpc_security_group_ids = ["${aws_security_group.aurora-sg.id}"]
  skip_final_snapshot    = true
}

resource "aws_security_group" "aurora-sg" {
  name   = "aurora-security-group"
  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# =================
# = Bastion Setup =
# =================

resource "aws_default_vpc" "default" {}

resource "aws_instance" "bastion" {
  ami                         = "ami-09a3e40793c7092f5"
  key_name                    = "${aws_key_pair.bastion_key.key_name}"
  instance_type               = "t2.micro"
  security_groups             = ["${aws_security_group.bastion-sg.name}"]
  associate_public_ip_address = true
}

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "deployer_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDN+rlcBFSeMUOyWR7WYoVobqU3k817tuPqfV6WSzi0gfu3nbNcnn3fNzARhUNbsHLsSXriayR01FkmOtrmEnDL8/u60RPUfcqVfnVr0bIq/zKypZ+Q8uZRKtEf/E4Cefhl+dU5cIhx2VmI7mJJzUnvM/Ar20L0r43Xh8o0FX0qp6co8UrUa4a9BNntBj7UK/jVFlLwYdI+N3Uj/BSVg6r5K/lbCdKsiYwB6I9Hi2o+PzHW5c4svA+A/9/de6f/GaXsnFGVFhu1Atg48JL/SQfsfvfUSSqUTYeMsYnK/vrMxUjfj6h4liF68mR1fsL6IGKxgHfZ6dYmLwkFo2QhmiC09TxewMYkvUoWk5ednjRdmVVrJGgOWgXqMb87F5xsalmhGyAqMyUMXXO6mcnuSviRUq9Kwba1vheqoih6SS9nYcBLvazWfr8b4Lj50RQtQEuG2se1CiOfc9QwI8VJeiQQJVdquIgev4VSqnAtfTRfpGTrdKWLhT40AdvbgTzP6475b46he9z3/VRrVmkgz5IEBw7agc0D1f7aBeZZBqk6iuwrcVLdLHlaIz9AphGEqWc2e7hnxRrWMzvJrJ0YAMJhgEEHGEHEX3vuNmtQYywasyu3P5fKvDQo+3qEk5t1H0NQ5ewo0LneGsx9ifpCPdPSo8rvkMGnifx9z61ro+vQpw=="
}

# ===========
# = Outputs =
# ===========

output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "bastion_public_dns" {
  value = "${aws_instance.bastion.public_dns}"
}

output "bastion_public_rds_instance_endpoint" {
  value = "${aws_rds_cluster_instance.cluster_instances.endpoint}"
}
