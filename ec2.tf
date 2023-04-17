terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  #ami           = "ami-007855ac798b5175e"
  instance_type = var.instancetype

  tags = {
    Name = var.tagname
  }
}
