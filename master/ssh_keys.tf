resource "aws_key_pair" "lemontech_key_pair" {
    key_name = "lemontech_key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDN+rlcBFSeMUOyWR7WYoVobqU3k817tuPqfV6WSzi0gfu3nbNcnn3fNzARhUNbsHLsSXriayR01FkmOtrmEnDL8/u60RPUfcqVfnVr0bIq/zKypZ+Q8uZRKtEf/E4Cefhl+dU5cIhx2VmI7mJJzUnvM/Ar20L0r43Xh8o0FX0qp6co8UrUa4a9BNntBj7UK/jVFlLwYdI+N3Uj/BSVg6r5K/lbCdKsiYwB6I9Hi2o+PzHW5c4svA+A/9/de6f/GaXsnFGVFhu1Atg48JL/SQfsfvfUSSqUTYeMsYnK/vrMxUjfj6h4liF68mR1fsL6IGKxgHfZ6dYmLwkFo2QhmiC09TxewMYkvUoWk5ednjRdmVVrJGgOWgXqMb87F5xsalmhGyAqMyUMXXO6mcnuSviRUq9Kwba1vheqoih6SS9nYcBLvazWfr8b4Lj50RQtQEuG2se1CiOfc9QwI8VJeiQQJVdquIgev4VSqnAtfTRfpGTrdKWLhT40AdvbgTzP6475b46he9z3/VRrVmkgz5IEBw7agc0D1f7aBeZZBqk6iuwrcVLdLHlaIz9AphGEqWc2e7hnxRrWMzvJrJ0YAMJhgEEHGEHEX3vuNmtQYywasyu3P5fKvDQo+3qEk5t1H0NQ5ewo0LneGsx9ifpCPdPSo8rvkMGnifx9z61ro+vQpw=="
} 


/* resource "aws_key_pair" "limonen_key_pair" {
  key_name   = "deployer_key"
  public_key = file("./keys/lemontech.pem.pub")
} */