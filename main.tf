provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "ap-northeast-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"

  tags {
    Name = "VPC領域：Terraform"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "Internet Gateway by Terraform"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags{
    Name = "Public route table by Terraform"
  }
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.1.1.0/24"

  tags {
    Name = "Public Subnet by Terraform"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.r.id}"
}
