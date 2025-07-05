# terraform.tfvars at ROOT level

vpc_cidr = "10.0.0.0/16"
vpc_name = "ECS-VPC"


public_subnet_cidrs = [
  "10.0.0.0/24",
  "10.0.1.0/24"
]

private_subnet_cidrs = [
  "10.0.10.0/24",
  "10.0.11.0/24"
]

azs = [
  "eu-west-2a",
  "eu-west-2b"
]

alb_sg_name  = "ALB SG"
ingress_cidr = "0.0.0.0/0"
ingress_port = 443

ecs_sg_name      = "ECS SG"
ecs_ingress_port = 3000

alb_name        = "ALB-LB"
tg_name         = "IP-ECS-TG"
tg_port         = 3000
listener_port   = 443

ecr_name             = "my-app-ecr"
image_tag_mutability = "MUTABLE"
scan_on_push         = true

ecs_name           = "ECS-Clusters"
ecs_family         = "APP-ECS-Family"
ecs_cpu            = 1024
ecs_memory         = 3072
container_port     = 3000
service_name       = "mongo"
ecs_desired_count  = 2

