# Data sources are used to retrive data from your aws account. It can be your ec2 instance public ip, ami-id, etc..,

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region=ap-south-1
}

resource "aws_instance" "data-demo"{
  ami="ami-0e53db6fd757e38c7"
  instance_type="t2.micro"
  tags = {
    Name = "EC2 Terraform"
  }
}

data "aws_instance" "data-resource" {
  filter {
    name = "tag:Name"
    value = "EC2 Terraform"
  }
  depends_on = [aws_instance.data-demo]
}

output "ec2_public_ip" {
  value=data.aws_instance.data-resource.public_ip
}
