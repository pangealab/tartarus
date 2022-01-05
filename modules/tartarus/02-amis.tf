# Define an Amazon Linux AMI.
data "aws_metasploitable3_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Metasploitable3-ubuntu"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}