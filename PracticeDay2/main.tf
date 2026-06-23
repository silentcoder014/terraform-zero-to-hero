	terraform {
		required_version = ">=1.8.0"
		required_providers{
			aws = {
				source = "hashicorp/aws"
				version = "~6.0"
			}
		}
	}
	
	
	
	provider  "aws"{
		alias = "dev"
		profile = "anurag.devOps" 
		region = "ap-south-2"
	}
	
	
	variable "ami_id" {
		type = string
		description = "Defines the Amazon Machine Image"
	}
	variable "server_type"{
		type = string
		description = "This tells about the server computational power" 
	}
	
	#In this section we will cover How to attach custom key_name to your ec2 instance 
	
	resource "aws_instance" "my_Instance"{
		provider = aws.dev
		instance_type = var.server_type
		ami = var.ami_id
		key_name = "testKey" 
	}
	
	
	output "instance_ip"{
		value = aws_instance.my_Instance.public_ip
	}

