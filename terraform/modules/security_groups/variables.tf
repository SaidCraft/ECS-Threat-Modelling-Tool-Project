variable "alb_sg_name" {
  description = "The name of the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to attach security group"
  type        = string
}

variable "ingress_cidr" {
  description = "CIDR Allowed to alb"
  type        = string
}

variable "ingress_port" {
  description = "Port allowed to ALB"
  type        = number
}

variable "ecs_sg_name" {
  description = "The name of the security group"
  type        = string
}


variable "ecs_ingress_port" {
  description = "Port allowed to ALB"
  type        = number
}