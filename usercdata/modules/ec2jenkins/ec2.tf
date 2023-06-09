resource "aws_instance" "ec2_jenkins" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # key name
  key_name = var.key_name
  subnet_id = "subnet-0d04171eef56ce328"

  user_data = file("./userdata.sh")
  tags = {
    Name = "Ec2-User-data"
  }
}
