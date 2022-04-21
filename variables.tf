
variable "vpc_cidr_block" {
  default = "172.16.0.0/16"
}

variable "subnet_cidr_block1" {
  default = "172.16.1.0/24"
}

variable "ami_g9" {
  default = "ami-015ebb80abc548b7f"
}

variable "instance_g9" {
  default = "t2.micro"
}

variable "region_g9" {
  default = "us-east-1"
}

variable "keyname_g9" {
  default = "vockey"
}