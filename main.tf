provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "ap-northeast-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

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
  availability_zone = "ap-northeast-1d"

  tags {
    Name = "Public Subnet by Terraform"
  }
}

resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.1.2.0/24"
  availability_zone = "ap-northeast-1d"

  tags {
    Name = "Private Subnet by Terraform"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_security_group" "wsg" {
  name = "web-sg"
  description = "web-sg security group created by terraform"
  vpc_id = "${aws_vpc.main.id}"

  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags{
    Name = "web-sg"
  }
}

resource "aws_security_group" "dsg" {
  name = "db-sg"
  description = "db-sg security group created by Terraform"
  vpc_id = "${aws_vpc.main.id}"

  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "auth" {
  key_name = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "web" {
  ami = "ami-08847abae18baa040" // Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  private_ip = "10.1.1.10"
  associate_public_ip_address = true
  security_groups = [
    "${aws_security_group.wsg.id}"
  ]
  key_name = "${aws_key_pair.auth.id}"

  tags {
    Name = "Web Server by Terraform"
  }
}

resource "aws_instance" "db" {
  ami = "ami-08847abae18baa040" // Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private.id}"
  associate_public_ip_address = false
  private_ip = "10.1.2.10"
  security_groups = [
    "${aws_security_group.dsg.id}"
  ]
  key_name = "${aws_key_pair.auth.id}"

  tags {
    Name = "DB Server by Terraform"
  }
}
