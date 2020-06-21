# Creating AWS Lambda Layer with Terraform in 3min
[Read the next Medium blog post]() 

The code is written for Python 3.8 runtime, but can be easily modified to support other runtimes as well. 

### Prerequisites
- [AWS account](https://aws.amazon.com/).
- Familiar with [AWS Lambda service](https://aws.amazon.com/lambda/).
- [IAM user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html) in your AWS account (“Programmatic access user” type).
- Installed [Terraform](https://www.terraform.io/downloads.html) on the local machine.
- Familiar with Terraform.
- Familiar with Bash (Linux).

### Folder Structure - Overview
- `prod` folder - production environment
- `main.tf` - main terraform script
- `variables.tf` - global variables
- `scripts` folder - contains the bash code for EC2’s user data
- `modules` folder - terraform modules for AWS services

### Folder Structure - Tree
├── README.md</br>
├── prod</br>
│    ├── main.tf</br>
│    ├── scripts</br>
│    └── variables.tf</br>
├── modules</br>
│    ├── tf-module-ec2</br>
│    ├── tf-module-iam-service-role</br>
│    ├── tf-module-lambda-layer</br>
│    ├── tf-module-s3-bucket</br>