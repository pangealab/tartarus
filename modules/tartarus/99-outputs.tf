# Output some useful variables for quick SSH access etc.
output "control-public_ip" {
  value = aws_eip.control_eip.public_ip
}

output "control-private_ip" {
  value = aws_eip.control_eip.private_ip
}

output "dopey-public_ip" {
  value = aws_eip.dopey_eip.public_ip
}

output "dopey-private_ip" {
  value = aws_eip.dopey_eip.private_ip
}

output "bashful-public_ip" {
  value = aws_eip.bashful_eip.public_ip
}

output "bashful-private_ip" {
  value = aws_eip.bashful_eip.private_ip
}