provider "aws" {
   region     = "eu-central-1"
   shared_credentials_files = ["/Users/rahulwagh/.aws/credentials"]
}

resource "aws_instance" "ec2_example" {
   ami           = "ami-0767046d1677be5a0"
   instance_type =  "t2.micro"
   tags = {
           Name = "Terraform EC2 "
   }
} // id

resource "null_resource" "null_resource_simple" {
   triggers = {
      id = timestamp()
   }
   provisioner "local-exec" {
      command = "echo Hello World"
   }
}
