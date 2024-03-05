provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "instance1" {
    ami ="ami-#############"
    instance_type = "t3.micro"
    tags = {
      "Name" = "first_instance"
    }

}

