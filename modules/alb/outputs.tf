output "alb_arn" {
  value = aws_lb.ALB.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.ip.arn
}

output "alb_dns_name" {
  value = aws_lb.ALB.dns_name
}