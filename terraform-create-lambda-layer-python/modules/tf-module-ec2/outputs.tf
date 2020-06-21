output "aws_ami_name" {
  value = join(",", data.aws_ami.amazon_linux.*.name)
}

output "aws_ami_id" {
  value = join(",", data.aws_ami.amazon_linux.*.id)
}

output "aws_ami_2_name" {
  value = join(",", data.aws_ami.amazon_linux_2.*.name)
}

output "aws_ami_2_id" {
  value = join(",", data.aws_ami.amazon_linux_2.*.id)
}

output "ec2_instance_id" {
  value = join(",", aws_instance.ec2_instance.*.id)
}