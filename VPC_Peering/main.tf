resource "aws_vpc" "vpc1" {             //vpc1 resource
    cidr_block = var.vpc1_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        name = "vpc1"
    }
}

resource "aws_vpc" "vpc2" {                //vpc2 resource
    cidr_block = var.vpc2_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        name = "vpc2"
    }
}

resource "aws_subnet" "vpc1_subnet" {             //vpc1 subnet resource
    vpc_id = aws_vpc.vpc1.id
    cidr_block = var.vpc1_subnet_cidr   
    availability_zone = var.availability_zone
      map_public_ip_on_launch = true

    tags = {
     
       name = "vpc1_subnet"
    }
}

resource  "aws_subnet" "vpc2_subnet" {             //vpc2 subnet resource
    vpc_id = aws_vpc.vpc2.id
    cidr_block = var.vpc2_subnet_cidr   
    availability_zone = var.availability_zone
      map_public_ip_on_launch = true

    tags = {
     
       name = "vpc2_subnet"
    }
} 

//IGW for VPC1

resource "aws_internet_gateway" "vpc1_igw" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        name = "vpc1_igw"
    }
}

//IGW for VPC2

resource "aws_internet_gateway" "vpc2_igw" {
    vpc_id = aws_vpc.vpc2.id
    tags = {
        name = "vpc2_igw"
    }
}

//route table for vpc1

resource "aws_route_table" "vpc1_rt" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        name = "vpc1_rt"
    }
}
resource "aws_route" "vpc1_route" {
    route_table_id = aws_route_table.vpc1_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc1_igw.id
}

//route table for vpc2
resource "aws_route_table" "vpc2_rt" {
    vpc_id = aws_vpc.vpc2.id
    tags = {
        name = "vpc2_rt"
    }
}   

resource "aws_route" "vpc2_route" {
    route_table_id = aws_route_table.vpc2_rt.id
    destination_cidr_block = "0.0.0/0"
    gateway_id = aws_internet_gateway.vpc2_igw.id
}

//  asscociate route table with vpc1 subnet

resource "aws_route_table_association" "vpc1_rt_assoc" {
    subnet_id = aws_subnet.vpc1_subnet.id
    route_table_id = aws_route_table.vpc1_rt.id
}

//  asscociate route table with vpc2 subnet

resource "aws_route_table_association" "vpc2_rt_assoc" {
    subnet_id = aws_subnet.vpc2_subnet.id
    route_table_id = aws_route_table.vpc2_rt.id
}

// VPC Peering Connection

resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id        = aws_vpc.vpc1.id
  peer_vpc_id   = aws_vpc.vpc2.id
  auto_accept   = true

  tags = {
    Name = "vpc1_to_vpc2_peering_connection"
  }
}

//route for vpc1 to reach vpc2

resource "aws_route" "vpc1_to_vpc2_route" {
  route_table_id         = aws_route_table.vpc1_rt.id
  destination_cidr_block = var.vpc2_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

//route for vpc2 to reach vpc1

resource "aws_route" "vpc2_to_vpc1_route" {
  route_table_id         = aws_route_table.vpc2_rt.id
  destination_cidr_block = var.vpc1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

//sg vpc1

resource "aws_security_group" "vpc1_sg" {
  name        = "vpc1_sg"
  description = "Security group for VPC 1"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0/0"]
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0/0"]
  }
  tags = {
    Name = "vpc1_sg"
  }
}

//sg vpc2

resource "aws_security_group" "vpc2_sg" {
  name        = "vpc2_sg"
  description = "Security group for VPC 2"
  vpc_id      = aws_vpc.vpc2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0/0"]
  }
  tags = {
    Name = "vpc2_sg"
  }
}
