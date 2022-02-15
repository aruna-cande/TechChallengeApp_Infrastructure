resource "aws_lb" "app_alb" {
  name               = "application-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.app_alb.id}"]
  subnets            = aws_subnet.public.*.id

  enable_deletion_protection = true

  tags = {
    Name        = "application-loadbalancer"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

resource "aws_security_group" "app_alb" {
  name        = "application-loadbalancer-sg"
  description = "inbound and outbound traffic for application"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow all incoming HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "application-loadbalancer-sg"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

resource "aws_lb_listener" "techchallange" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404 - Not found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "techchallange_rule" {
  listener_arn = aws_lb_listener.techchallange.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_alb_target_group" "main" {
  name        = "${var.service}-tg"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/healthcheck"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 25
    healthy_threshold   = 2
    unhealthy_threshold = 5
    matcher             = "200"
  }

  tags = {
    Name        = "${var.service}-alb-target-group"
    Group       = "${var.service}"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}