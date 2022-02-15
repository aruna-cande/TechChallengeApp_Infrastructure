resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.service
  retention_in_days = 30

  tags = {
    Name        = "${var.service}-cloudwatch-log-group"
    Group       = "${var.service}"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}
