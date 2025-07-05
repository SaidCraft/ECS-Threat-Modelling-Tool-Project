module "ecr" {
  source = "./modules/ecr"

  ecr_name             = var.ecr_name
  image_tag_mutability = var.image_tag_mutability
  scan_on_push         = var.scan_on_push
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}





# ALB Security Group

module "security_groups" {
  source = "./modules/security_groups"

  alb_sg_name  = var.alb_sg_name
  vpc_id       = module.vpc.vpc_id
  ingress_cidr = var.ingress_cidr
  ingress_port = var.ingress_port

  ecs_sg_name      = var.ecs_sg_name
  ecs_ingress_port = var.ecs_ingress_port

}

module "alb" {
  source = "./modules/alb"

  alb_name           = var.alb_name
  security_group_ids = [module.security_groups.alb_sg_id]
  public_subnet_ids  = module.vpc.public_subnet_ids
  tg_name            = var.tg_name
  tg_port            = var.tg_port
  vpc_id             = module.vpc.vpc_id
  listener_port      = var.listener_port
  certificate_arn    = var.certificate_arn
}


module "ecs" {
  source = "./modules/ecs"

  ecs_name           = var.ecs_name
  ecs_family         = var.ecs_family
  ecs_cpu            = var.ecs_cpu
  ecs_memory         = var.ecs_memory
  execution_role_arn = var.execution_role_arn
  container_image    = var.container_image
  container_port     = var.container_port
  service_name       = var.service_name
  ecs_desired_count  = var.ecs_desired_count

  private_subnets  = module.vpc.private_subnet_ids
  ecs_sg           = [module.security_groups.ecs_sg_id]
  target_group_arn = module.alb.target_group_arn



}


