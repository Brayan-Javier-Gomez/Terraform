variable "flavor" {
    type = string
    default = "t3.micro"
}

variable "ebs_opt" {
    type = bool
    default = false
}

variable "core_count"{
    type = number
    default = 4
}

variable "environment" {
  type = list(string)
  default = [ "dev","beta","prod" ]
}

variable "amis"{
    type = map(string)
    default = {
      "amazon" = "ami-##############"
      "ubuntu" = "ami-##############"
      "red-hat" = "ami-##############"
    }
}