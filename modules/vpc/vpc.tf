resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}
resource "aws_subnet" "public_1" {
  
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnets[0]
  availability_zone = var.az[0]
  map_public_ip_on_launch = true 
}
resource "aws_subnet" "public_2" {

  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnets[1]
  availability_zone = var.az[1]
  map_public_ip_on_launch = true
  
}

resource "aws_subnet" "private_1" {

  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnets[0]
  availability_zone = var.az[0]
}
resource "aws_subnet" "private_2" {

  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnets[1]
  availability_zone = var.az[1]
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  }

resource "aws_eip" "nat1" {
  depends_on = [aws_internet_gateway.main]
}

resource "aws_eip" "nat2" {
  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "gw1" {

  allocation_id = aws_eip.nat2.id
  subnet_id = aws_subnet.public_1.id

}

resource "aws_nat_gateway" "gw2" {

  allocation_id = aws_eip.nat1.id
  subnet_id = aws_subnet.public_2.id
}
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  
}

resource "aws_route_table" "private1" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw1.id
  }
  
}
resource "aws_route_table" "private2" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw2.id
  }
}
resource "aws_route_table_association" "public1" {

  subnet_id = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public2" {

  subnet_id = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private1" {

  subnet_id = aws_subnet.private_1.id  
  route_table_id = aws_route_table.private1.id
}
resource "aws_route_table_association" "private2" {

  subnet_id = aws_subnet.private_2.id
  route_table_id = aws_route_table.private1.id
}

