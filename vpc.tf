provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "java_homevpc" {
  cidr_block = var.vpc_cidr

  tags = {
    name = "JAVAHOMEVPC"
  }
}

resource "aws_internet_gateway" "javahome_igw" {
  vpc_id = "aws_vpc.java_homevpc.id"
  tags = {
    name = "JAVAHOMEVPC_IG"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.subnets_cidr)
  vpc_id            = "var.aws_vpc.java_homevpc.id"
  availability_zone = "element(var.azs,count.index)"
  cidr_block        = "element(var.subnets_cidr,count.index)"

  tags = {
    name = "subnet-count.index"
  }
}

resource "aws_route_table" "public_rt" {

  vpc_id = "aws_vpc.java_homevpc.id"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "aws_internet_gateway.javahome_igw.id"
  }

  tags = {
    name = "PublicRT"
  }
}
resource "aws_route_table_association" "a" {
  count          = "${length(var.subnets_cidr)}"
  subnet_id      = "element(aws_subnet.public.*.id, count.index)"
  route_table_id = "aws_route_table.public_rt.id"
}

resource "aws_security_group" "webservers" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "aws_vpc.java_homevpc.id"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_Tls"
  }
}



