# Create a role which tartarus instances will assume.
# This role has a policy saying it can be assumed by ec2
# instances.
resource "aws_iam_role" "tartarus-instance-role" {
  name = "${var.cluster_id}-instance-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

# This policy allows an instance to forward logs to CloudWatch, and
# create the Log Stream or Log Group if it doesn't exist.
resource "aws_iam_policy" "tartarus-policy-forward-logs" {
  name        = "${var.cluster_id}-instance-forward-logs"
  path        = "/"
  description = "Allows an instance to forward logs to CloudWatch"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": [
        "arn:aws:logs:*:*:*"
      ]
    }
  ]
}
EOF
}

# Attach the policies to the roles.
resource "aws_iam_policy_attachment" "tartarus-attachment-forward-logs" {
  name       = "${var.cluster_id}-attachment-forward-logs"
  roles      = [aws_iam_role.tartarus-instance-role.name]
  policy_arn = aws_iam_policy.tartarus-policy-forward-logs.arn
}

# Create a instance profile for the role.
resource "aws_iam_instance_profile" "tartarus-instance-profile" {
  name  = "${var.cluster_id}-instance-profile"
  role = aws_iam_role.tartarus-instance-role.name
}

# Create a instance profile for the dopey
resource "aws_iam_instance_profile" "tartarus-dopey-instance-profile" {
  name  = "${var.cluster_id}-dopey-instance-profile"
  role = aws_iam_role.tartarus-instance-role.name
}

# Create a instance profile for the metasploit3windows
resource "aws_iam_instance_profile" "tartarus-metasploit3windows-instance-profile" {
  name  = "${var.cluster_id}-metasploit3windows-instance-profile"
  role = aws_iam_role.tartarus-instance-role.name
}

# Create a instance profile for the control
resource "aws_iam_instance_profile" "tartarus-control-instance-profile" {
  name  = "${var.cluster_id}-control-instance-profile"
  role = aws_iam_role.tartarus-instance-role.name
}

# Create a user and access key for tartarus-only permissions
resource "aws_iam_user" "tartarus-aws-user" {
  name = "${var.cluster_id}-aws-user"
  path = "/"
}

# Create a IAM User Policy
resource "aws_iam_user_policy" "tartarus-aws-user" {
  name = "${var.cluster_id}-aws-user-policy"
  user = aws_iam_user.tartarus-aws-user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeVolume*",
        "ec2:CreateVolume",
        "ec2:CreateTags",
        "ec2:DescribeInstance*",
        "ec2:AttachVolume",
        "ec2:DetachVolume",
        "ec2:DeleteVolume",
        "ec2:DescribeSubnets",
        "ec2:CreateSecurityGroup",
        "ec2:DescribeSecurityGroups",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:CreateLoadBalancerListeners",
        "ec2:DescribeRouteTables",
        "elasticloadbalancing:ConfigureHealthCheck",
        "ec2:AuthorizeSecurityGroupIngress",
        "elasticloadbalancing:DeleteLoadBalancerListeners",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:ModifyLoadBalancerAttributes",
        "elasticloadbalancing:DescribeLoadBalancerAttributes"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Create a IAM Access Key
resource "aws_iam_access_key" "tartarus-aws-user" {
  user = aws_iam_user.tartarus-aws-user.name
}

# Create an SSH keypair
resource "aws_key_pair" "keypair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}