resource "aws_subnet" "app_subnet" {
  count = length(var.app_subnet_cidr_blocks)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.app_subnet_cidr_blocks[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "app-${data.aws_availability_zones.available.names[count.index]}"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

resource "aws_subnet" "db_subnet" {
  count = length(var.db_subnet_cidr_blocks)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.db_subnet_cidr_blocks[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "db-${data.aws_availability_zones.available.names[count.index]}"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "public-${data.aws_availability_zones.available.names[count.index]}"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = aws_subnet.db_subnet.*.id

  tags = {
    Name        = "db_subnet_group"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}
