[
  {
    "essential": true,
    "command": [${command}],
    "image": "${image}",
    "name": "${name}",
    "portMappings": [
      {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_log_group_name}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "code"
      }
    },
    "environment": [
        ${envs}
    ],
    "secrets": [
        ${secrets}
    ]
  }
]