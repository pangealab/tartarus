# Create the Heracles Cluster using our module
module "tartarus" {
  source          = "./modules/tartarus"
  region          = "${var.region}"
  instance_count  = "${var.instance_count}"
  amisize         = "t2.large"
  volumesize      = "100"
  vpc_cidr        = "15.0.0.0/16"
  subnetaz        = "${var.subnetaz}"
  subnet_cidr     = "15.0.1.0/24"
  key_name        = "${var.cluster_name}-${var.region}"
  public_key_path = "${var.public_key_path}"
  cluster_name    = "${var.cluster_name}"
  cluster_id      = "${var.cluster_name}-${var.region}"
}

# Output some useful variables for quick SSH access etc.
output "metasploit3ubuntu-public_ip" {
  value = module.tartarus.metasploit3ubuntu-public_ip
}

# Output some useful variables for Ansible
output "metasploit3windows-public_ip" {
  value = module.tartarus.metasploit3windows-public_ip
}

# Output some useful variables for Ansible
output "control-private_ip" {
  value = module.tartarus.control-private_ip
}