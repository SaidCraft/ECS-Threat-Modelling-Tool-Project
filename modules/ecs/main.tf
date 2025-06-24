
resource "aws_ecs_cluster" "main" {
  name = var.ecs_name
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.ecs_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "web"
      image     = var.container_image
      cpu       = var.ecs_cpu
      memory    = var.ecs_memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
    }
    ]
  )
}

resource "aws_ecs_service" "mongo" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.ecs_desired_count


  network_configuration {
    subnets         = var.private_subnets
    security_groups = var.ecs_sg
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "web"
    container_port   = var.container_port
  }

}