# Create the Heracles Cluster using our module
module "tartarus" {
  source          = "./modules/tartarus"
  region          = "${var.region}"
  instance_count  = "${var.instance_count}"
  amisize         = "t2.xlarge"
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
output "dopey-public_ip" {
  value = module.tartarus.dopey-public_ip
}

output "dopey-private_ip" {
  value = module.tartarus.dopey-private_ip
}

# Output some useful variables for Ansible
output "bashful-public_ip" {
  value = module.tartarus.bashful-public_ip
}

output "bashful-private_ip" {
  value = module.tartarus.bashful-private_ip
}

# Output some useful variables for Ansible
output "control-public_ip" {
  value = module.tartarus.control-public_ip
}

output "control-private_ip" {
  value = module.tartarus.control-private_ip
}