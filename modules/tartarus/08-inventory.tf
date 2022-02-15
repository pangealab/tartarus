//  Collect together all of the output variables needed to build to the final
//  inventory from the inventory template

resource "local_file" "inventory" {
 content = templatefile("inventory.template.cfg", {
      control-public_ip = aws_eip.control_eip.public_ip,
      dopey-public_ip = aws_eip.dopey_eip.public_ip,
      bashful-public_ip = aws_eip.bashful_eip.public_ip
  }
 )
 filename = "inventory-${var.cluster_name}.cfg"
}