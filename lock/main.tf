provider "aws" {
   region     = "us-east-1"
}

resource "aws_instance" "ec2_example" {
    ami = "ami-007855ac798b5175e"
    instance_type = "t2.micro"
    tags = {
      Name = "EC2 Instance with remote state"
    }
}

terraform {
    backend "s3" {
        bucket = "demotf-terraform-s3-bucket-25042023"
        key    = "ec2/terraform/remote/s3/terraform.tfstate"
        region     = "us-east-1"
        dynamodb_table = "dynamodb-state-locking"
    }
}
