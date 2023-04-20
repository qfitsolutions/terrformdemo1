resource "aws_instance" "app_server" {
  #ami           = "ami-007855ac798b5175e"
  count          = 4 
  ami            = data.aws_ami.ubuntu.id
  instance_type  = var.instancetype
  subnet_id      = var.subnetid
  user_data = <<EOF
               #!/bin/bash
               echo "hello world" > /tmp/userdata 
           EOF

  tags = {
    Name = "my-machine-${count.index}"
  }
}

