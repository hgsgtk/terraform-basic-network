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

resource "aws_subnet" "web" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.1.1.0/24"

  tags {
    Name = "Public Subnet by Terraform"
  }
}
