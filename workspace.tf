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
  instance_name="${terraform.workspace}-instance"  # use interpolation concept to display the current workspace while executing
}

resource "aws_instance" "demo" {
  ami=var.ami_id
  instance_type=var.instance_type
  tags = {
    Name = local.instance_name
  }
}

# terraform workspace list -> To list workspaces
# terraform workspace new dev -> To Create workspace
# terraform workspace show -> To dispaly current workspace
# terraform workspace select dev -> To switch workspace
