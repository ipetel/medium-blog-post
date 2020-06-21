output "s3_bucket_arn" {
  value = join(",", aws_s3_bucket.s3-bucket.*.arn)
}

output "s3_bucket_name" {
  value = join(",", aws_s3_bucket.s3-bucket.*.id)
}