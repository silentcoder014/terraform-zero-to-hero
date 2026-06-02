terraform {
  required_version = ">=1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }
}
provider "aws" {
  alias   = "dev"
  profile = "anurag_devOps"
  region  = "ap-south-2" # Set your desired AWS region
}

# resource "aws_iam_role" "ssm_role" {
#   provider = aws.dev
#   name     = "ec2-ssm-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action    = "sts:AssumeRole"
#       Effect    = "Allow"
#       Principal = { Service = "ec2.amazonaws.com" }
#     }]
#   })
# }

# resource "aws_iam_role_policy_attachment" "ssm_attach" {
#   provider   = aws.dev
#   role       = aws_iam_role.ssm_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }

# resource "aws_iam_instance_profile" "ssm_profile" {
#   provider = aws.dev
#   name     = "ec2-ssm-profile"
#   role     = aws_iam_role.ssm_role.name
# }

resource "aws_instance" "example" {
  provider      = aws.dev
  ami           = "ami-070e5bd3ff10324f8" # Specify an appropriate AMI ID
  instance_type = "t3.micro"
  # public_ip            = true
  # iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  #   subnet_id     = "subnet-07c7e9e8feafc1383"
  # key_name = "anurag_key_pair"
}

output "instance_ip" {
  value = aws_instance.example.public_ip
}

# This file help you to create an EC2 instance in AWS using Terraform. It defines the AWS provider with a specific profile and region,  
# and then creates an EC2 instance with a specified AMI ID and instance type. The commented-out sections show how to set up an IAM 
# role and instance profile for SSM (AWS Systems Manager) if you want to manage the instance using SSM. 
# You can customize the AMI ID, instance type, subnet ID, and key pair as needed for your specific use case.