resource "aws_db_instance" "rds" {
  name                        = var.service
  identifier                  = var.service
  allocated_storage           = var.allocated_storage
  engine                      = "postgres"
  engine_version              = "9.6"
  instance_class              = var.db_instance_class
  username                    = aws_ssm_parameter.rds_username.value
  password                    = aws_ssm_parameter.rds_password.value
  db_subnet_group_name        = aws_db_subnet_group.default.name
  vpc_security_group_ids      = ["${aws_security_group.rds.id}"]
  port                        = 5432
  storage_type                = "gp2"
  multi_az                    = true
  publicly_accessible         = false
  auto_minor_version_upgrade  = false
  allow_major_version_upgrade = false
  apply_immediately           = true
  parameter_group_name        = aws_db_parameter_group.default.name

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = "${var.service}-rds"
    Group       = "${var.service}"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

resource "aws_db_parameter_group" "default" {
  name   = "${var.service}-rds-pg"
  family = "postgres9.6"

  parameter {
    name  = "work_mem"
    value = "1048576"
  }

  tags = {
    Name        = "${var.service}-parameter-group"
    Group       = "${var.service}"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.service}-rds-sg"
  description = "inbound and outbound traffic for rds"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow all incoming Postgres traffic from ECS and the bastion"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["${aws_security_group.service_sg.id}"]
  }

  egress {
    description     = "Allow all outgoing Postgres traffic to ECS and the bastion"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["${aws_security_group.service_sg.id}"]
  }

  tags = {
    Name        = "rds-sg"
    Group       = "${var.service}"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}
