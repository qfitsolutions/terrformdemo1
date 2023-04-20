resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.web.id
}

resource "aws_instance" "web" {
  ami               = "ami-035b3c7efe6d061d5"
  availability_zone = "us-east-1f"
  instance_type     = "t2.micro"
  subnet_id = "subnet-0d04171eef56ce328"
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1f"
  size              = 1
}
