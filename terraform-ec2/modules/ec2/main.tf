provider "aws" {
  version = "~> 3.0"
  region  = "ap-southeast-1"
  access_key = ""
  secret_key = ""
}


locals {
  launch_template_version = "$Latest"
  private_subnet_1a = "subnet-02de36d5bcc46402d"
  key_pair = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5fBwjtVkrD5eJZhrWPt3rukUSo0P44T7kyGOskqrVaJfgWEOca+66V29Xxklcyr6PZClAl7sYVcj+9fHeOoSlt3HruSo0O+2bdhFeFdkgd+TqPG/aY/dHLPRzc7Q33MIflX5t82+AlKfemO6nzfOEJh5WJEMAgy1CuuDfixZWwZYzYaCkKQtKx4QOOSXZWN+NGLIQRbbYYVtutHxEtHzuXl75rZ/v4Nhd5H87YbtELdCmpvj2Lx1pzFPSkbrtEZKEJKztJc2AYRkgso7OZRIwJ/cGhQZOGlUJvOa5XK72AH0k05j14P6kuQQ6dZW2Ark//MIT24vw22LteJFtOSLccOe9lAXKIDNXGzlr7LQE3hqUI4VC4HP12l/zeRoZQSkYZiPhCalPS7jC6WvC1dHltQoDabwkuibOFKEcJHbPd08vQ8Say33/L0jCOwQUD/n/YSdiI3LjO4BMbTwZFgkSWJaRMe5ObJvdp18/d4YktY99lZEixKUJSk52aZB+Dfxoyp4JTWbmBe1t3VreUZ1tCYNRiqr9pULSXC+9Vb/fb3cThLCSYS84bccCy2mufMpcr+0LzW7bXmacUS3c9pME7JIaGxKDsKx8DST0857dvEglqSAier0YL5vox6fZLCUpVovFwUkSVzi8KX6hQ5efLCq00ko1MTsSU4VIUrspRw== vietbunder@gmail.com"
  igw_id = "igw-057c19ee33fd335ec"
}

resource "aws_instance" "ec2_dev" {
  ami                           = var.ami_id
  availability_zone             = var.region
  instance_type                 = var.ec2_type
  key_name                      = var.key_name
  subnet_id                     = local.private_subnet_1a
  associate_public_ip_address   = true

  root_block_device {
    delete_on_termination = true
    volume_size           = 30
    volume_type           = "gp2"
  }

  tags =  {
      Name = var.instance_name
  }
}

resource "aws_key_pair" "dev_key" {
  key_name   = var.public_key
  public_key = local.key_pair

}

resource "aws_launch_template" "lt_development" {
  name_prefix   = "dev_instance"
  image_id      = var.ami_id
  instance_type = var.ec2_type
}

resource "aws_lb_target_group" "tg_development" {
  name        = "tg-development"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_dev_id
}


resource "aws_autoscaling_group" "asg_development" {
  name_prefix               = var.instance_name
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.subnet_id
  
  launch_template {
    id      = aws_launch_template.lt_development.id
    version = local.launch_template_version
  }

  tag {
      key = "Name"
      value = var.instance_name
      propagate_at_launch = true
  }
}

resource "aws_eip" "bar" {
  vpc = true

  instance                  = aws_instance.ec2_dev.id
  associate_with_private_ip = aws_instance.ec2_dev.private_ip
  depends_on                = [aws_instance.ec2_dev]
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_dev_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = 1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
