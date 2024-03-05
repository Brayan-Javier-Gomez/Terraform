provider "aws" {
    region = "us-east-1"
}

# variable "flavor" {
#   type = string
#   #default = "t3.micro"
# }

resource "aws_instance" "instance1" {
    ami = var.amis.amazon
    instance_type = var.flavor
    tags = {
      "Name" = "first_instance"
      "Environment" = var.environment[1]
    }
    ebs_optimized = var.ebs_opt

}

