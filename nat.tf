resource "aws_eip" "nat" {
  vpc      = true
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main-subnet-public-1.id
  depends_on = [aws_internet_gateway.main-gateway]

  tags = {
    Name = "gateway-nat"
  }
}

// route table for NAT
resource "aws_route_table" "main-route-table-private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "main-route-table-private"
  }
}

//route table private associations

resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = aws_subnet.main-subnet-private-1.id
  route_table_id = aws_route_table.main-route-table-private.id
}

resource "aws_route_table_association" "main-private-2-a" {
  subnet_id     = aws_subnet.main-subnet-private-2.id
  route_table_id = aws_route_table.main-route-table-private.id
}