provider "aws" {
  region     = var.input_region
  access_key = var.input_iam_user_access_key
  secret_key = var.input_iam_user_secret_key
}

data "aws_ami" "amazon_linux_2" {
  count       = var.createModule == "true" && var.input_amazon_ami_name=="amazon linux 2" ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "amazon_linux" {
  count       = var.createModule == "true" && var.input_amazon_ami_name=="amazon linux" ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
  
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ec2_instance" {
  count                = var.createModule == "true" && (var.input_amazon_ami_name=="amazon linux" || var.input_amazon_ami_name=="amazon linux 2") ? 1 : 0
  ami                  = var.input_amazon_ami_name=="amazon linux" ? data.aws_ami.amazon_linux[0].id:data.aws_ami.amazon_linux_2[0].id
  instance_type        = var.input_instance_type
  tags                 = var.input_general_tags
  user_data            = file("${var.input_script_folder_path}")
  iam_instance_profile = var.input_instance_iam_role
  root_block_device {
        volume_size = "8"
        volume_type = "gp2"
    }
}