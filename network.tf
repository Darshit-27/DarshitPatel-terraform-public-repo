# Fetch default VPC
data "aws_vpc" "default" {
  default = true
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "default-igw"
  }
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "rt_assoc" {
  subnet_id      = aws_default_subnet.default_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
