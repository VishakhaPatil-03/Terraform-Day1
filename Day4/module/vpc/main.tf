# 1. VPC
resource "aws_vpc" "my-vpc" {
  cidr_block           = var.vpc_cidr # Fixed: Removed quotes and updated variable name
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# 2. Internet Gateway
resource "aws_internet_gateway" "my-internet-gateway" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-internet-gateway"
  }
}

# 3. Elastic IP
resource "aws_eip" "my-eip" {
  domain = "vpc"
  tags = {
    Name = "my-eip"
  }
}

# 4. NAT Gateway
resource "aws_nat_gateway" "my-nat" {
  allocation_id = aws_eip.my-eip.id
  subnet_id     = aws_subnet.my-public-subnet.id # Fixed resource reference type
  tags = {
    Name = "my-nat-gateway"
  }
}

# 5. Public Subnet
resource "aws_subnet" "my-public-subnet" { # Fixed resource type
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.public_subnet_az
  tags = {
    Name = "my-public-subnet"
  }
}

# 6. Public Route Table
resource "aws_route_table" "my-public-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0" # Fixed: Corrected malformed CIDR block
    gateway_id = aws_internet_gateway.my-internet-gateway.id
  }
  tags = {
    Name = "my-public-route-table"
  }
}

# 7. Public Route Table Association
resource "aws_route_table_association" "my-public-rt-ass" {
  subnet_id      = aws_subnet.my-public-subnet.id # Fixed resource reference type
  route_table_id = aws_route_table.my-public-route-table.id
}

# 8. Private Subnet
resource "aws_subnet" "my-private-subnet" { # Fixed resource type
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_subnet_az
  tags = {
    Name = "my-private-subnet"
  }
}

# 9. Private Route Table
resource "aws_route_table" "my-private-rt" {
  vpc_id = aws_vpc.my-vpc.id # Fixed: Added .id suffix
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my-nat.id # Fixed: Added .id suffix
  }
  tags = {
    Name = "my-private-rt"
  }
}

# 10. Private Route Table Association
resource "aws_route_table_association" "my-private-rt-ass" {
  subnet_id      = aws_subnet.my-private-subnet.id # Fixed resource reference type
  route_table_id = aws_route_table.my-private-rt.id
}

# 11. Security Group
resource "aws_security_group" "sg" {
  name        = var.sg_name # Fixed: Bound this to your variable input
  vpc_id      = aws_vpc.my-vpc.id # Fixed: Added .id suffix
  description = "this was the new sg"

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
