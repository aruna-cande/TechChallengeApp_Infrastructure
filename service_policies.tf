resource "aws_iam_policy" "ecs_execution_role_policy" {
  name        = "ecs-execution-role-policy"
  description = "allow service to access ecr and create logs"
  policy      = data.aws_iam_policy_document.ecs_execution_role_policy_document.json
}

data "aws_iam_policy_document" "ecs_execution_role_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ssm:GetParameters",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecs_autoscale_role_policy" {
  name   = "ecs-autoscale-role-policy"
  policy = data.aws_iam_policy_document.ecs_autoscale_role_policy_document.json
}

data "aws_iam_policy_document" "ecs_autoscale_role_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "cloudwatch:DescribeAlarms",
    ]

    resources = ["*"]
  }
}
