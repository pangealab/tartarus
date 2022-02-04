# This security group allows intra-server communication on all ports with all
# protocols.
resource "aws_security_group" "tartarus-vpc" {
  name        = "${var.cluster_id}-sg"
  description = "Default security group that allows all instances in the VPC to talk to each other over any port and protocol."
  vpc_id      = aws_vpc.tartarus.id

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
    cidr_blocks = ["15.0.1.0/24"]
  }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-sg"
    )
  )
}

# This security group allows public ingress to the instances for HTTP, HTTPS
# and common HTTP/S proxy ports.
resource "aws_security_group" "tartarus-public-ingress" {
  name        = "${var.cluster_id}-ingress"
  description = "Security group that allows ALL public ingress to instances"
  vpc_id      = aws_vpc.tartarus.id

  # HTTP
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-ingress"
    )
  )
}

# This security group allows public egress from the instances for HTTP and
# HTTPS, which is needed for yum updates, git access etc etc.
resource "aws_security_group" "tartarus-public-egress" {
  name        = "${var.cluster_id}-egress"
  description = "Security group that allows ALL egress to the internet for instances"
  vpc_id      = aws_vpc.tartarus.id

  # All Traffic
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-egress"
    )
  )
}

# This security group restricts egress from the instances for HTTP and
# HTTPS, which is needed for yum updates, git access etc etc.
resource "aws_security_group" "tartarus-restricted-egress" {
  name        = "${var.cluster_id}-restricted"
  description = "Security group restricts egress to the internet for instances"
  vpc_id      = aws_vpc.tartarus.id

  # All Traffic
  # egress {
  #   from_port = "0"
  #   to_port   = "0"
  #   protocol  = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-restricted"
    )
  )
}

# Security group which allows SSH access to a host. Used for the bastion.
resource "aws_security_group" "tartarus-ssh" {
  name        = "${var.cluster_id}-ssh"
  description = "Security group that allows public ingress over SSH."
  vpc_id      = aws_vpc.tartarus.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-ssh"
    )
  )
}