terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "track-infra"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-locking"
  }
}
locals {
  env = "stagging"
}
variable "machine-type" {
  description="specify machine type"
  type=string
}
variable "ami_id" {
  description="ami   id"
  type=string
  default="ami-02b49a24cfb95941c"
}
variable "machine-count" {
  description="machine count"
  type=number
  default=2
}
variable "machine-env" {
  description="mahcine envs"
  type=list(map(string))
  default=[
    { Name="Dev-Env", Project="p1"},
    { Name="Test-Env", Project="p2"}
  ]
}
#resource "aws_instance" "demo-vm" {
#  count = var.machine-count
#  ami = var.ami_id
#  instance_type = var.machine-type
#  tags=var.machine-env[count.index]
#}

locals {
  ingress_rules = [
    { port = 22,
      description = "port 22"
    },
    { port = 443,
      description = "port 443"
    }
  ]
}

resource "aws_vpc" "new" {
 tags = {
 Name="${local.env}-vpc"
 }
 cidr_block = "10.0.0.0/16"
}
resource "aws_security_group" "new" {
  depends_on = [ aws_vpc.new ]
  name = "${local.env}-sg"
  vpc_id = aws_vpc.new.id
  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      to_port = ingress.value.port
      from_port = ingress.value.port
      description = ingress.value.description
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "tcp"
    }
  }
}
#output "aws-instance-id" {
#  value = aws_instance.demo-vm[*].id
#}

#output "public-ip" {
#  value = aws_instance.demo-vm[*].public_ip
#} 
