provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "vpc" {
  cidr_block       = "192.168.0.0/16"
  tags = {
    Name = "vpc-ejemplo"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subred-ejemplo"
  }
}