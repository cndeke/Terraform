#vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "ChiVPC"
  }
}
#subnets
resource "aws_subnet" "pub1" {
  cidr_block = var.pub1_cidr_block
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone = var.pub1_az

  tags = {
    Name = "ChiPub1"
  }
}

resource "aws_subnet" "pub2" {
  cidr_block = var.pub2_cidr_block
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone = var.pub2_az

  tags = {
    Name = "ChiPub2"
  }
}

resource "aws_subnet" "pri1" {
  cidr_block = var.pri1_cidr_block
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  availability_zone = var.pri1_az

  tags = {
    Name = "ChiPri1"
  }
}
#igw
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Chiigw"
  }
}
#routetable
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw.id
    }
  tags = {
    Name = "ChiRT"
  }
}
resource "aws_route_table_association" "rta1" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.pub1.id
}
resource "aws_route_table_association" "rta2" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.pub2.id
}
#sg
resource "aws_security_group" "sg" {
  name        = "ChiSG"
  description = "SG for ec2"
  vpc_id      = aws_vpc.vpc.id

  ingress {
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ingress {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ingress {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }


  tags = {
    Name = "ChiSG"
  }
}