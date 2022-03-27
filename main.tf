terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.27"
    }
  }
  required_version = ">= 0.12"
}

provider "aws" {
    profile = "default"
    region = "us-east-1"
}

resource "aws_instance" "app_server" {
    ami = "ami-04505e74c0741db8d" //Ubuntu 20.04 LTS
    instance_type = "t2.micro"
    user_data = <<-EOF
        #!/bin/bash
        cd /home/ubuntu
        echo "<h1>Feito com o terraform.</h1>" > index.html
        nohup busybox httpd -f -p 8080 &
        EOF
    tags = {
        Name = "Ubuntu - First Instance"
    }
    key_name = "iac-alura"
}