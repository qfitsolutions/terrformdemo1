terraform {
  backend "s3" {
    bucket = "terraformdemo17apr23"
    key    = "ec2/dev/terraform.tf"
    region = "us-east-1"
  }
}
