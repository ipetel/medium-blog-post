provider "aws" {
  region     = var.input_region
  access_key = var.input_iam_user_access_key
  secret_key = var.input_iam_user_secret_key
}

resource "aws_lambda_layer_version" "lambda_layer" {
  count = var.createModule == "true" ? 1 : 0
  layer_name          = var.input_layer_name
  description         = var.input_desc
  s3_bucket           = var.input_s3_bucket_name
  s3_key              = var.input_s3_obj_key
  compatible_runtimes = var.input_runtime
}