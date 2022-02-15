resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "internet_gateway"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}


resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name        = "nat_gateway_eip"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}



resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.0.id

  tags = {
    Name        = "nat_gateway"
    Group       = "techallangeapp"
    GitRepoName = "TechChallengeApp_Infrastructure"
  }
}
