variable "vpc_cidr"{
    description = "CIDR  block for the entire vpc"
    type = string
}

variable "public_subnet_1_cidr"{
    description = "CIDR for sthe public subnet"
    type = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR for the private subnet"
  type = string
}