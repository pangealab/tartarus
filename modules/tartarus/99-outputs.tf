# Output some useful variables for quick SSH access etc.

output "metasploit3-public_ip" {
  value = aws_eip.metasploit3_eip.public_ip
}

output "metasploit3-private_ip" {
  value = aws_instance.metasploit3.private_ip
}