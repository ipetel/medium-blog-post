provider "aws" {
  region     = var.input_region
  access_key = var.input_iam_user_access_key
  secret_key = var.input_iam_user_secret_key
}

# IAM Role
resource "aws_iam_role" "role" {
  count = var.createModule == "true" ? 1 : 0
  name  = "allow-EC2-PutObject-to-S3-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = var.input_general_tags
}

resource "aws_iam_instance_profile" "instance_profile" {
  count = var.createModule == "true" ? 1 : 0
  name  = "allow-EC2-PutObject-to-S3-role"
  role  = aws_iam_role.role[0].name
}

# IAM Policy
resource "aws_iam_policy" "policy" {
  count  = var.createModule == "true" ? 1 : 0
  name   = "allow-EC2-PutObject-to-S3-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": "${var.input_bucket_arn}/*"
        }
    ]
}
EOF
}

# IAM Policy-Role attachment
resource "aws_iam_role_policy_attachment" "attachment" {
  count      = var.createModule == "true" ? 1 : 0
  role       = aws_iam_role.role[0].id
  policy_arn = aws_iam_policy.policy[0].arn
}