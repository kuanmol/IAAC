# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = {
    Name = "gw"
  }
}

# VPC
resource "aws_vpc" "custom-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "custom-vpc"
  }
}

# Public Subnets
resource "aws_subnet" "vpc-public-1" {
  vpc_id                  = aws_vpc.custom-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "vpc-public-1"
  }
}

resource "aws_subnet" "vpc-public-2" {
  vpc_id                  = aws_vpc.custom-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "vpc-public-2"
  }
}

resource "aws_subnet" "vpc-public-3" {
  vpc_id                  = aws_vpc.custom-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "vpc-public-3"
  }
}

# Private Subnets
resource "aws_subnet" "vpc-private-1" {
  vpc_id                  = aws_vpc.custom-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "vpc-private-1"
  }
}

resource "aws_subnet" "vpc-private-2" {
  vpc_id                  = aws_vpc.custom-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "vpc-private-2"
  }
}

resource "aws_subnet" "vpc-private-3" {
  vpc_id                  = aws_vpc.custom-vpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1c"

  tags = {
    Name = "vpc-private-3"
  }
}

# Public Route Table
resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.custom-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Route Table Associations for Public Subnets
resource "aws_route_table_association" "public-1-a" {
  subnet_id      = aws_subnet.vpc-public-1.id
  route_table_id = aws_route_table.rt-public.id
}

resource "aws_route_table_association" "public-2-a" {
  subnet_id      = aws_subnet.vpc-public-2.id
  route_table_id = aws_route_table.rt-public.id
}

resource "aws_route_table_association" "public-3-a" {
  subnet_id      = aws_subnet.vpc-public-3.id
  route_table_id = aws_route_table.rt-public.id
}
