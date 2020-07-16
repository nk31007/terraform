variable "aws_region" {
  default = "us-east-2"
}

variable "subnets_cidr" {
  type    = list(string)
  default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "azs" {
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "webservers_ami" {
  default = "ami-0a83d9223efc49d62"
}

variable "instance_type" {
  default = "t2.micro"
}

