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

variable "private_subnets" {
  type = list(string)
}

variable "ecs_sg" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "execution_role_arn" {
  type = string
}