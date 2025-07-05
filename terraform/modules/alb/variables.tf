variable "alb_name" {
  description = "Application Load Balancer name"
  type        = string

}

variable "security_group_ids" {
  description = "Which SG is attached to this ALB"
  type        = list(string)

}

variable "public_subnet_ids" {
  description = "List of public subnet CIDRs"
  type        = list(string)

}

variable "tg_name" {
  description = "Target group name"
  type        = string

}

variable "tg_port" {
  description = "Target group port"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID for target group"
  type        = string
}

variable "listener_port" {
  description = "Listener Port"
  type        = number

}

variable "certificate_arn" {
  type = string
}