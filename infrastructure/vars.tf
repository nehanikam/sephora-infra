variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AWS_REGION_AZ_a" {
	default = "ap-south-1a"
}

variable "AWS_REGION_AZ_b" {
	default = "ap-south-1b"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "/home/neha/.ssh/id_rsa"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "/home/neha/.ssh/id_rsa.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    ap-south-1 = "ami-0ccfb82eb6753816c"
  }
}
variable "RDS_PASSWORD" { }

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "INSTANCE_USERNAME" {
	default = "ubuntu"
}