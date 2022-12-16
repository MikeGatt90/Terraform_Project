# Configure the AWS VPC
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpc"
  }
}

# Configure 2 public subnets
resource "aws_subnet" "public_1" {
  vpc_id                  = "vpc-0a6a9da6288361818"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = "vpc-0a6a9da6288361818"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_2"
  }
}

# Configure 2 private subnets
resource "aws_subnet" "private_1" {
  vpc_id                  = "vpc-0a6a9da6288361818"
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private_Subnet_1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = "vpc-0a6a9da6288361818"
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet_2"
  }
}

# Configure 2 RDS subnets
resource "RDS_subnet" "private_1" {
  vpc_id                  = "vpc-0a6a9da6288361818"
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "RDS_subnet_1"
  }
}

resource "RDS_subnet" "private_1" {
  vpc_id                  = "vpc-0a6a9da6288361818"
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "RDS_subnet_1"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = "vpc-0a6a9da6288361818"

  tags = {
    Name = "ig"
  }
}
# Create route table to internet gateway
resource "aws_route_table" "project_rt" {
  vpc_id = "vpc-0a6a9da6288361818"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "project-rt"
  }
}

# Associate public subnets with route table
resource "aws_route_table_association" "public_route_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.project_rt.id
}

resource "aws_route_table_association" "public_route_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.project_rt.id
}
