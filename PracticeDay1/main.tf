#custom_security group 
#in specific az the instance gonna created 
#custom_key pair gonna used 

data "aws_vpc" "default" {
  provider = aws.dev
  default  = true
}

resource "aws_security_group" "mySg" {
  provider    = aws.dev
  name        = "MySecurityGroup"
  description = "Allow SSH and HTTP traffic"

  vpc_id = data.aws_vpc.default.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "myKeyPair" {
  provider   = aws.dev
  key_name   = "anurag-local-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_subnets" "azs_subnet" {
  provider = aws.dev
  filter {
    name   = "availability-zone"
    values = ["ap-south-2a"]
  }
}


resource "aws_instance" "MyInstance" {
  provider               = aws.dev
  ami                    = "ami-09aa82e803f05d496"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.mySg.id]
  key_name               = aws_key_pair.myKeyPair.key_name
  subnet_id              = data.aws_subnets.azs_subnet.ids[0]
 root_block_device{ 
    volume_size=8
    volume_type="gp3"
    delete_on_termination=true 
 }
}

