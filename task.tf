locals {
  name               = var.service
  image              = var.image
  aws_log_group_name = aws_cloudwatch_log_group.log_group.name
  envs               = join(",\n", "${formatlist("{\"name\": \"%s\", \"value\": \"%s\"}", keys(local.environment_variables), values(local.environment_variables))}")
  secrets            = join(",\n", "${formatlist("{\"name\": \"%s\", \"valueFrom\": \"%s\"}", keys(local.ssm_secrets), values(local.ssm_secrets))}")
}

resource "aws_ecs_task_definition" "task" {
  family = var.service
  container_definitions = templatefile(
    "${path.module}/templates/container_definition.json.tpl",
    {
      name               = local.name,
      command            = join(",", "${formatlist("\"%s\"", var.command)}"),
      image              = local.image,
      aws_log_group_name = local.aws_log_group_name,
      region             = var.region,
      envs               = local.envs,
      secrets            = local.secrets
  })
  network_mode             = "awsvpc"
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  tags = {
    Name        = "${var.service}-task"
    Group       = "${var.service}"
    GitRepoName = "application-terraform"
  }
}