//Docs https://www.terraform.io/docs/providers/aws/r/vpc.html

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  enable_classiclink = false

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main-subnet-public-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"

  tags = {
    Name = "main-subnet-public-1"
  }
}

resource "aws_subnet" "main-subnet-public-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"

  tags = {
    Name = "main-subnet-public-2"
  }
}

resource "aws_subnet" "main-subnet-private-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"

  tags = {
    Name = "main-subnet-private-1"
  }
}

resource "aws_subnet" "main-subnet-private-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1c"

  tags = {
    Name = "main-subnet-private-2"
  }
}

resource "aws_internet_gateway" "main-gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-gateway"
  }
}

// route table
resource "aws_route_table" "main-route-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gateway.id
  }

  tags = {
    Name = "main-route-table"
  }
}

//route table public associations

resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-subnet-public-1.id
  route_table_id = aws_route_table.main-route-table.id
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id     = aws_subnet.main-subnet-public-2.id
  route_table_id = aws_route_table.main-route-table.id
}