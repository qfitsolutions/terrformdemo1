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