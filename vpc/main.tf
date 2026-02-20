resource "aws_vpc" "custom_vpc"{
   cidr_block = var.vpc_cidr

   tags = {
    name = "custom_vpc"
   }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = "ap-south-1a"

  tags = {
    Name = "public subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = var.private_subnet_1_cidr
  availability_zone = "ap-south-1b"

  tags = {
    Name = "private subnet"
  }
}

resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_internet_gateway" "public_rt" {
    vpc_id = aws_vpc.custom_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.custom_igw.id
    }

    tags = {
      Name = "Public route table"
    }
    
}

 resource "aws_route_table_association" "public_rt_association" {
   subnet_id = aws_subnet.public-subnet.id
   route_table_id = aws_internet_gateway.public_rt.id
 }

 resource "aws_security_group" "public_sg" {

      name = "HTTP"
      vpc_id = aws_vpc.custom_vpc.id

      ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      egress {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        cidr_blocks = ["0.0.0.0/0"]
      }
   
 }