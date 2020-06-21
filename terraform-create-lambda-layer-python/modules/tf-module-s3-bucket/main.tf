provider "aws" {
  region     = var.input_region
  access_key = var.input_iam_user_access_key
  secret_key = var.input_iam_user_secret_key
}

resource "aws_s3_bucket" "s3-bucket" {
  count  = var.createModule == "true" ? 1 : 0
  bucket = var.input_bucket_name
  region = var.input_region
  tags   = var.input_general_tags
}