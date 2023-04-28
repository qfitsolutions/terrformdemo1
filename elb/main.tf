resource "aws_lb" "collectlb" {
  name               = "collect-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "collect-lb-tf"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_s3_bucket" "lb_logs" {
  bucket = "collect-lb-tf-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "production"
  }
}