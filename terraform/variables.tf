variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "alb_sg_name" {
  description = "The name of the security group"
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

variable "alb_name" {
  description = "Application Load Balancer name"
  type        = string

}

variable "tg_name" {
  description = "Target group name"
  type        = string

}

variable "tg_port" {
  description = "Target group port"
  type        = number
}

variable "listener_port" {
  description = "Listener Port"
  type        = number

}


variable "ecs_name" {
  type = string
}

variable "ecs_family" {
  type = string
}

variable "ecs_cpu" {
  type = number
}

variable "ecs_memory" {
  type = number
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "service_name" {
  type = string
}

variable "ecs_desired_count" {
  type = number
}

variable "execution_role_arn" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "ecr_name" {
  type = string
}

variable "image_tag_mutability" {
  type = string
}

variable "scan_on_push" {
  type = bool
}