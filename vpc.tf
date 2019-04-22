resource "aws_vpc" "tfVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraformVPC"
  }
}

resource "aws_subnet" "tfPub1" {
  vpc_id     = "${aws_vpc.tfVPC.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "terraformPublicSubnet1"
  }
}

resource "aws_subnet" "tfPub2" {
  vpc_id     = "${aws_vpc.tfVPC.id}"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"
  tags = {
    Name = "terraformPublicSubnet2"
  }
}

resource "aws_internet_gateway" "tfIGW" {
  vpc_id = "${aws_vpc.tfVPC.id}"

  tags = {
    Name = "terraformIGW"
  }
}

resource "aws_route_table" "tfR" {
  vpc_id = "${aws_vpc.tfVPC.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tfIGW.id}"
  }
}

resource "aws_route_table_association" "tfPubR1" {
  subnet_id      = "${aws_subnet.tfPub1.id}"
  route_table_id = "${aws_route_table.tfR.id}"
}

resource "aws_route_table_association" "tfPubR2" {
  subnet_id      = "${aws_subnet.tfPub2.id}"
  route_table_id = "${aws_route_table.tfR.id}"
}
