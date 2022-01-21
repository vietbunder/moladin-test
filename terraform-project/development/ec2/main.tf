locals {
    vpc_dev_id = "vpc-04b5f1cab7503db9b"
    ami_id = "ami-0a7587d725542cb4d"
    instance_name = "dev_instance"
    region = "ap-southeast-1a"
    ec2_type = "t2.micro"
    key_name = "dev-key"
    subnet_id = ["subnet-02de36d5bcc46402d", "subnet-047c43f9022badfeb", "subnet-0bca5ca13ca663e41"]
    public_ip = ""
    desired_capacity = "1"
    max_size = "3"
    min_size = "1"
    public_key = "dev-key"
}

module "ec_development_jojo" {
    source = "../../modules/ec2"
    instance_name = local.instance_name
    vpc_dev_id  = local.vpc_dev_id
    ami_id = local.ami_id
    region = local.region
    ec2_type = local.ec2_type
    public_key = local.public_key
    subnet_id = local.subnet_id
    public_ip = local.public_ip
    desired_capacity = local.desired_capacity
    max_size = local.max_size
    min_size = local.min_size
}