# Define the VPC.
resource "aws_vpc" "tartarus" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}"
    )
  )
}

# Create an Internet Gateway for the VPC.
resource "aws_internet_gateway" "tartarus" {
  vpc_id = aws_vpc.tartarus.id

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-igw"
    )
  )
}

# Create a public subnet.
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.tartarus.id
  cidr_block              = var.subnet_cidr
  availability_zone       = lookup(var.subnetaz, var.region)
  map_public_ip_on_launch = true
  depends_on              = [aws_internet_gateway.tartarus]

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-pub"
    )
  )
}

# Create a route table allowing all addresses access to the IGW.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tartarus.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tartarus.id
  }

  # Use our common tags and add a specific name.
  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.cluster_id}-prt"
    )
  )
}

# Now associate the route table with the public subnet - giving
# all public subnet instances access to the internet.
resource "aws_route_table_association" "public-subnet" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public.id
}
