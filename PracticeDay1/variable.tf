variable "instance_type"{
    description = "Instance type for the EC2 Instance"
    type = string 
    default  = "t3.small"
}


variable "ami_id"{
    description = "AMI ID for th EC2 Instance"
    type = string 
}

