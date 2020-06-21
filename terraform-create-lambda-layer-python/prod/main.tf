
module "s3-bucket" {
  createModule = "true"
  source       = "../modules/tf-module-s3-bucket" 
  
  input_region              = var.aws_region.n_virginia
  input_iam_user_access_key = var.aws_iam_user.access_key
  input_iam_user_secret_key = var.aws_iam_user.secret_key
  input_general_tags        = var.general_tags
  input_bucket_name         = "<S3-BUCKET-NAME>"
}

module "iam-ec2-s3-role" {
  createModule = "true"
  source       = "../modules/tf-module-iam-service-role"

  input_region              = var.aws_region.n_virginia
  input_iam_user_access_key = var.aws_iam_user.access_key
  input_iam_user_secret_key = var.aws_iam_user.secret_key
  input_general_tags        = var.general_tags
  input_bucket_arn          = module.s3-bucket.s3_bucket_arn
}

module "ec2-instance" {
  createModule = "true"
  source       = "../modules/tf-module-ec2" 
  
  input_region              = var.aws_region.n_virginia
  input_iam_user_access_key = var.aws_iam_user.access_key
  input_iam_user_secret_key = var.aws_iam_user.secret_key
  input_general_tags        = var.general_tags
  input_amazon_ami_name     = "<EC2-OPERATING-SYSTEM>"
  input_instance_type       = "<EC2-INSTANCE-TYPE>"
  input_script_folder_path  = "scripts/ec2_user_data.sh"
  input_instance_iam_role   = module.iam-ec2-s3-role.instance_profile_name
}

module "lambda-layer" {
  createModule = "false"
  source       = "../modules/tf-module-lambda-layer"
  
  input_region              = var.aws_region.n_virginia
  input_iam_user_access_key = var.aws_iam_user.access_key
  input_iam_user_secret_key = var.aws_iam_user.secret_key
  input_layer_name          = "<LAMBDA-LAYER-NAME>"
  input_desc                = "<LAMBDA-LAYER-DESCRIPTION>"
  input_runtime             = ["python3.8"]
  input_s3_bucket_name      = module.s3-bucket.s3_bucket_name
  input_s3_obj_key          = "<THE-ZIP-FILE-NAME-IN-S3-BUCKET>.zip"
}