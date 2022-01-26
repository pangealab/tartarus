//  Collect together all of the output variables needed to build to the final
//  inventory from the inventory template

resource "local_file" "inventory" {
 content = templatefile("inventory.template.cfg", {
      control-public_ip = aws_eip.control_eip.public_ip,
      metasploit3ubuntu-public_ip = aws_eip.metasploit3ubuntu_eip.public_ip,
      metasploit3windows-public_ip = aws_eip.metasploit3windows_eip.public_ip
  }
 )
 filename = "inventory-${var.cluster_name}.cfg"
}