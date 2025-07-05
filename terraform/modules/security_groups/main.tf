# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Allow HTTP inbound and all outbound"
  vpc_id      = var.vpc_id


  tags = {
    Name = var.alb_sg_name
  }
}

# Add explicit ingress rule (already done)
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = var.ingress_cidr
  from_port         = var.ingress_port
  to_port           = var.ingress_port
  ip_protocol       = "tcp"
}

# Add explicit egress rule too 
resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Security Group for ECS Tasks
resource "aws_security_group" "ecs_sg" {
  name        = var.ecs_sg_name
  description = "Allow inbound from ALB and all outbound"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.ecs_sg_name
  }
}

# Allow HTTP (port 3000) from ALB SG
resource "aws_vpc_security_group_ingress_rule" "ecs_ingress" {
  security_group_id            = aws_security_group.ecs_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = var.ecs_ingress_port
  to_port                      = var.ecs_ingress_port
  ip_protocol                  = "tcp"
}

# Add explicit egress rule too 
resource "aws_vpc_security_group_egress_rule" "ecs_egress" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}