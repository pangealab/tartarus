# metasploit3 Elastic IP
resource "aws_eip" "metasploit3_eip" {
  instance = aws_instance.metasploit3.id
  vpc      = true
  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-metasploit3-eip"
    )
  )   
}

# metasploit3 Server
resource "aws_instance" "metasploit3" {
  ami                  = data.aws_ami.metasploitable3_ubuntu.id
  instance_type        = var.amisize
  iam_instance_profile = aws_iam_instance_profile.tartarus-metasploit3-instance-profile.id
  subnet_id            = aws_subnet.public-subnet.id

  vpc_security_group_ids = [
    aws_security_group.tartarus-vpc.id,
    aws_security_group.tartarus-ssh.id,
    aws_security_group.tartarus-public-egress.id,
  ]

  //  metasploit3 Server Root Disk
  root_block_device {
    volume_size = var.volumesize
    volume_type = "gp2"
    tags = merge(
      local.common_tags,
      map(
        "Name", "${var.cluster_id}-metasploit3-root"
      )
    )    
  }  

  key_name = aws_key_pair.keypair.key_name

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-metasploit3"
    )
  )
}
