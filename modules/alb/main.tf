resource "aws_lb" "ALB" {
  name               = var.alb_name
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.public_subnet_ids
  tags = {
    Environment = var.alb_name
  }
}

resource "aws_lb_target_group" "ip" {
  name        = var.tg_name
  port        = var.tg_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {

    path = "/"
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = var.listener_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip.arn
  }
}
