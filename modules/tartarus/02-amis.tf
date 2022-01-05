# Define an Amazon Linux AMI.
data "aws_ami" "metasploitable3_ubuntu" {
  most_recent = true
  owners      = ["454428865299"]

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