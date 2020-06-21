output "iam_role_instance_profile_name" {
  value = module.iam-ec2-s3-role.instance_profile_name
}

output "iam_role_arn" {
  value = module.iam-ec2-s3-role.iam_role_arn
}

output "ec2_instance_id" {
  value = module.ec2-instance.ec2_instance_id
}