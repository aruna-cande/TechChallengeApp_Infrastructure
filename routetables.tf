resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "public-route-table"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidr_blocks)
  route_table_id = aws_route_table.public.id
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}

resource "aws_route_table" "app-private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "app-route-table"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}


resource "aws_route" "nat" {
  route_table_id         = aws_route_table.app-private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.app_subnet_cidr_blocks)
  route_table_id = aws_route_table.app-private.id
  subnet_id      = element(aws_subnet.app_subnet.*.id, count.index)
}

resource "aws_route_table" "db-private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "db-route-table"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}

resource "aws_route_table_association" "db-private" {
  count          = length(var.db_subnet_cidr_blocks)
  route_table_id = aws_route_table.db-private.id
  subnet_id      = element(aws_subnet.db_subnet.*.id, count.index)
}
