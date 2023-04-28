resource "aws_lb" "collectlb" {
  name               = "collect-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-04086a1fcf30c383a"]
  subnets            = ["subnet-0f2e6ce6044d06789","subnet-024b306dc09b49de2","subnet-04c716179f0eeb783","subnet-0a34b1e39d7084972","subnet-0e01cf6ca7bee4173","subnet-0e88e8746d4a489b6"]

  enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.id
#     prefix  = "collect-lb-tf"
#     enabled = true
#   }

  tags = {
    Environment = "production"
  }
#   depends_on = [
#     aws_s3_bucket.lb_logs
#   ] 
}

# resource "aws_s3_bucket" "lb_logs" {
#   bucket = "collect-lb-tf-bucket"

#   tags = {
#     Name        = "My bucket"
#     Environment = "production"
#   }
# }

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0ef615c510b77dcc3"
}

resource "aws_instance" "web" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t3.micro"
  count = 2
  security_groups = ["sg-04086a1fcf30c383a"]
  user_data = <<EOF
        #! /bin/bash
        sudo apt update 
        sudo apt install -y nginx
        sudo service nginx start
        sudo service nginx enable
        echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
        EOF
  tags = {
    Name = "instance1"
    app = "${count.index}"
  }
}
resource "aws_lb_target_group_attachment" "test1" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.web[0].id
  port             = 80
}
resource "aws_lb_target_group_attachment" "test2" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.web[1].id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.collectlb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}