resource "aws_lb" "ingress" {
  name = var.nlb_name

  internal           = false
  load_balancer_type = "network"

  subnets = data.aws_ssm_parameter.public_subnets[*].value

  enable_cross_zone_load_balancing = true
  enable_deletion_protection       = false

  tags = {
    Name = var.eks_name
  }
}

resource "aws_lb_target_group" "main" {

  name     = format("%s-http", var.eks_name)
  port     = 8080
  protocol = "TCP"
  vpc_id   = data.aws_ssm_parameter.vpc.value
}

resource "aws_lb_listener" "main" {

  load_balancer_arn = aws_lb.ingress.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}