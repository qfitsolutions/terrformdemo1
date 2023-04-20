variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ChangedName"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-2"
}

variable "instance_size_small" {
  description = "Instance size small"
  type        = string
  default     = "t3.micro"
}

variable "redundant_count" {
  description         = "Default redundancy - base number of instances to create for redundant services"
  type                = number
  default             = 1
}

variable "ami" {
  description = "Ubuntu 20.04 AMI"
  type        = string
  default     = "ami-0015a39e4b7c0966f"
}

variable "environment_name" {
  description         = "Environment Name"
  type                = string
  default             = "dev"
}

variable "client_name" {
  description         = "Client Name"
  type                = string
  default             = "sandbox"
}

variable "instances" {
  description = "Map of modules names to configuration."
  type        = map
  default     = {
    testing-sandbox-dev = {
      instance_count          = 2,
      instance_type           = "t3.micro",
      environment             = "dev"
    },
    testing-sandbox-test = {
      instance_count          = 1,
      instance_type           = "t3.micro",
      environment             = "test"
    }
  }
}

resource "aws_instance" "ec2-instance" {
  for_each = var.instances

  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type
  subnet_id      = var.subnetid
  tags = {
    Name = "testing-${each.value.instance_count}.${var.environment_name}.${var.client_name}"
    client = var.client_name
    environment = var.environment_name
  }
}
