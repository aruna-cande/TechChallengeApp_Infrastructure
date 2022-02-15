
resource "random_string" "username" {
  length  = 16
  special = false
  number  = false
}

resource "aws_ssm_parameter" "rds_username" {
  name      = "/rds/${var.service}/username"
  type      = "SecureString"
  overwrite = true
  value     = random_string.username.result

  tags = {
    Name        = "techchallangeapp db user name"
    Group       = "techchallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

resource "random_password" "password" {
  length  = 16
  number  = true
  special = false
}

resource "aws_ssm_parameter" "rds_password" {
  name      = "/rds/${var.service}/password"
  type      = "SecureString"
  overwrite = true
  value     = random_password.password.result

  tags = {
    Name        = "techchallangeapp db name"
    Group       = "techchallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}