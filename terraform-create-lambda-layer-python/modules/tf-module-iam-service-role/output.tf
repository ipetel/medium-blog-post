output "iam_role_arn" {
  description = "The IAM role ARN"
  value = join(",", aws_iam_role.role.*.arn)
}

output "instance_profile_name" {
  description = "The IAM instance profile ARN"
  value = join(",", aws_iam_instance_profile.instance_profile.*.name)
}