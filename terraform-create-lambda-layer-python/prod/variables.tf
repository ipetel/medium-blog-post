# Generic AWS
variable "aws_region" {
  description = "AWS regions"
  default = {
    n_virginia = "us-east-1",
    oregon = "us-west-2",
    ireland = "eu-west-1"
  }
}

# IAM user
variable "aws_iam_user" {
  description = "AWS iam user"
  default = {
    access_key = "<ACCESS-KEY-ID>"
    secret_key = "<SECRET-ACCESS-KEY>"
  }
}

# tags
variable "general_tags" {
  description = "general tags for all provisioned resources"
  default     = {
    Project = "Lambda Layer by Terraform"
    Author = "<YOUR-NAME>"
    Environment = "prod"
    Terraform = "True"
  }
}