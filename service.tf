resource "aws_ecs_service" "service" {
  name            = var.service
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = "${aws_ecs_task_definition.task.family}:${aws_ecs_task_definition.task.revision}"
  desired_count   = var.min_capacity

  network_configuration {
    security_groups = ["${aws_security_group.service_sg.id}"]
    subnets         = aws_subnet.app_subnet.*.id
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_name   = aws_ecs_task_definition.task.family
    container_port   = 80
  }
}

resource "aws_security_group" "service_sg" {
  name        = "${var.service}-sg"
  description = "inbound and outbound traffic for application"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow all incoming HTTP traffic from the app subnet and the ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = aws_subnet.app_subnet.*.cidr_block
    security_groups = ["${aws_security_group.app_alb.id}"]
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.service}-sg"
    Group       = "${var.service}"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}
