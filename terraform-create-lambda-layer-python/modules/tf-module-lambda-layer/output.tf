output "lambda-layer-arn" {
  value = join(",", aws_lambda_layer_version.lambda_layer.*.arn)
}