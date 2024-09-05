terraform {
  required_providers {
  aws = {
    source = "hashicorp/aws"
  }
  }
}

provider "aws" {
  region=var.region
}

locals {
  instance_name="${terraform.workspace}-instance"
}

resource "aws_instance" "demo" {
  ami=var.ami_id
  instance_type=var.instance_type
  tags = {
    Name = local.instance_name
  }
}
