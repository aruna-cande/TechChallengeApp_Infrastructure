variable "region" {
  type = string
}

// networking
variable "vpc_cidr_block" {
  type = string
}

variable "app_subnet_cidr_blocks" {
  type = list(string)
}

variable "db_subnet_cidr_blocks" {
  type = list(string)
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
}

//service vars
variable "service" {
  type = string
}

variable "image" {
  type = string
}

variable "container_cpu" {
  type    = string
  default = 256
}

variable "container_memory" {
  type    = string
  default = 512
}

variable "min_capacity" {
  type    = string
  default = 1
}

variable "max_capacity" {
  type    = string
  default = 1
}

variable "command" {
  type = list(string)
}

//service env vars
locals {
  environment_variables = {
    "VTT_DBNAME"     = "${aws_db_instance.rds.name}"
    "VTT_DBPORT"     = "${aws_db_instance.rds.port}"
    "VTT_DBHOST"     = "${aws_db_instance.rds.address}"
    "VTT_LISTENHOST" = "0.0.0.0"
    "VTT_LISTENPORT" = 80
  }

  ssm_secrets = {
    "VTT_DBUSER"     = "${aws_ssm_parameter.rds_username.arn}"
    "VTT_DBPASSWORD" = "${aws_ssm_parameter.rds_password.arn}"
  }
}

//rds
variable "allocated_storage" {
  type = string
}

variable "db_instance_class" {
  type = string
}


