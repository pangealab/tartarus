# Output some useful variables for quick SSH access etc.

output "metasploit3ubuntu-public_ip" {
  value = aws_eip.metasploit3ubuntu_eip.public_ip
}

output "metasploit3windows-public_ip" {
  value = aws_eip.metasploit3windows_eip.public_ip
}