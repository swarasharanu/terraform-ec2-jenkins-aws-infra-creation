provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ubuntu_instance" {
  ami             = "ami-07d9b9ddc6cd8dd30"  # Replace with your Ubuntu 22.04 AMI
  instance_type   = "t2.large"
  key_name        = "devsecops"  
  user_data       = "${file("./install_jenkins.sh")}"
  user_data_replace_on_change = true
  tags = {
    Name = "Jenkins"
  }
}

output "instance_public_ip" {
  value = aws_instance.ubuntu_instance.public_ip
}
