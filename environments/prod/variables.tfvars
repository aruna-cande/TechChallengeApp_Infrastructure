region="ap-southeast-2"
// networking
vpc_cidr_block="10.0.0.0/16"
app_subnet_cidr_blocks=[
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
]
db_subnet_cidr_blocks=[
    "10.0.7.0/24",
    "10.0.8.0/24",
    "10.0.9.0/24"
]
public_subnet_cidr_blocks=[
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
]
//service vars
service="techchallangeapp"
image="registry.hub.docker.com/servian/techchallengeapp:latest"
command=["serve"]
//rds
allocated_storage="10"
db_instance_class="db.t2.micro"