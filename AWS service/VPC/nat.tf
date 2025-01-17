resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  subnet_id     = aws_subnet.vpc-public-1.id
  allocation_id = aws_eip.nat.id
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.custom-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "private"
  }
}
resource "aws_route_table_association" "private-1-a" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.vpc-private-1.id
}
resource "aws_route_table_association" "private-1-b" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.vpc-private-2.id
}
resource "aws_route_table_association" "private-1-c" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.vpc-private-3.id
}