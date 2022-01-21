variable "vpc_dev_id" {
  description = "VPC ID that will be applied"
  type = string
  default = "" 
}

variable "ami_id" {
    description = "AMI ID"
    type = string
    default = "" 
}

variable "region" {
    description = "Region with AZ name"
    type = string
    default = "" 
}

variable "instance_name" {
    description = "Region with AZ name"
    type = string
    default = "" 
}
variable "ec2_type" {
    description = "EC2 Instance Type"
    type = string
    default = "" 
}

variable "key_name" {
    description = "Key Name for Key Access"
    type = string
    default = "" 
}

variable "subnet_id" {
    description = "List of subnet id" 
    type = list(string)
    default = [""]
}

variable "public_ip" {
    description = "Elastic Public IP"
    type = string
    default = "" 
}

variable "desired_capacity" {
    description = "Desired Capacity for ASG"
    type = string
    default = null 
}

variable "max_size" {
    description = "Max Size ASG"
    type = string
    default = null 
}

variable "min_size" {
    description = "Min Size ASG"
    type = string
    default = null 
}

variable "public_key" {
    description = "Public Key for EC2"
    type = string
    default = "" 
}