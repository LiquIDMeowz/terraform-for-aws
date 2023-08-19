data "aws_availability_zones" "available" {}
# Custom VPC
resource "aws_vpc" "ec2_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "EC2 VPC"
  }
}

# Subnet eu-central-1a
resource "aws_subnet" "public_eu_central_1a" {
  vpc_id            = aws_vpc.ec2_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "Public Subnet eu-central-1a"
  }
}

# Subnet eu-central-1b
resource "aws_subnet" "public_eu_central_1b" {
  vpc_id            = aws_vpc.ec2_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1b"
  tags = {
    Name = "Public Subnet eu-central-1b"
  }
}

# Subnet eu-central-1c
resource "aws_subnet" "public_eu_central_1c" {
  vpc_id            = aws_vpc.ec2_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1c"
  tags = {
    Name = "Public Subnet eu-central-1c"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "ec2_igw" {
  vpc_id = aws_vpc.ec2_vpc.id
  tags = {
    Name = "EC2 - Internet Gateway"
  }
}

# Route Table for Internet Cccess
resource "aws_route_table" "EC2-RT" {
  vpc_id = aws_vpc.ec2_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2_igw.id
  }
  tags = {
    Name = "Public Subnets Route Table for EC2VPC"
  }
}

# Subnet -> Route Table Association for eu-central-1a
resource "aws_route_table_association" "ec2_vpc_eu_central_1a_public" {
  subnet_id      = aws_subnet.public_eu_central_1a.id
  route_table_id = aws_route_table.EC2-RT.id
}

# Subnet -> Route Table Association for eu-central-1b
resource "aws_route_table_association" "ec2_vpc_eu_central_1b_public" {
  subnet_id      = aws_subnet.public_eu_central_1b.id
  route_table_id = aws_route_table.EC2-RT.id
}

# Subnet -> Route Table Association for eu-central-1c
resource "aws_route_table_association" "ec2_vpc_eu_central_1c_public" {
  subnet_id      = aws_subnet.public_eu_central_1c.id
  route_table_id = aws_route_table.EC2-RT.id
}