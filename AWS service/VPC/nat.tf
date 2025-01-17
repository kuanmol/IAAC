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
resource "aws_route_table_association" "" {
  route_table_id = ""

}