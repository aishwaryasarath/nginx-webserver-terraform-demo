terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.2.0"
    }
  }
}


resource "aws_security_group" "sgnginx-nginx" {
  name        = "sgnginx-nginx"
  description = "Allow ssh & http traffic"


  ingress {
    description      = "allow https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  ingress {
    description      = "allow http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  ingress {
    description      = "allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

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

resource "aws_instance" "Nginx-instance" {

  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  security_groups = ["${aws_security_group.sgnginx-nginx.name}"]

  key_name = "terra-nginx"
  user_data = <<-EOF
          #! /bin/bash
          sudo yum install epel-release
          sudo yum update -y
          sudo amazon-linux-extras enable nginx1.12
          sudo yum -y install nginx
          sudo systemctl start nginx
          sudo systemctl enable nginx
          chmod 2775 /usr/share/nginx/html
          find /usr/share/nginx/html -type d -exec chmod 2775 {} \;
          find /usr/share/nginx/html -type f -exec chmod 0664 {} \;
          echo "<h3> Nginx server</h3>" > /usr/share/nginx/html/index.html

  EOF
  tags = {
    Name = "Nginx-demo"
  }
}
