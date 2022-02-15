resource "aws_iam_role" "ecs_execution_role" {
  name               = "ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_execution_role.json

  tags = {
    Name        = "ecs-execution-role"
    Group       = "techchallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

data "aws_iam_policy_document" "ecs_execution_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = [
        "ecs-tasks.amazonaws.com",
      ]

      type = "Service"
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_attachement" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.ecs_execution_role_policy.arn
}

resource "aws_iam_role" "ecs_autoscale_role" {
  name               = "ecs-autoscale-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_autoscale_role.json

  tags = {
    Name        = "ecs-autoscale-role"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

data "aws_iam_policy_document" "ecs_autoscale_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = [
        "application-autoscaling.amazonaws.com",
      ]

      type = "Service"
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_autoscale_role_attachement" {
  role       = aws_iam_role.ecs_autoscale_role.name
  policy_arn = aws_iam_policy.ecs_autoscale_role_policy.arn
}
