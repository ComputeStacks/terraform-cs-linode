variable "linode_api_key" {
	type = string
}
variable "ssh_users" {
	type = list
	default = ["computestacks"]
}

##
# Region
# curl -H "Authorization: Bearer ${LINODE_API_KEY}" https://api.linode.com/v4/regions | jq '.data | .[] | .id'
#
# "ap-west"
# "ca-central"
# "ap-southeast"
# "us-central"
# "us-west"
# "us-east"
# "eu-west"
# "ap-south"
# "eu-central"
# "ap-northeast"
variable "region" {
	type = string
	default = "us-west"
}

##
# Linode Package
# curl -H "Authorization: Bearer ${LINODE_API_KEY}" https://api.linode.com/v4/linode/types | jq '.data | .[] | .id'
# "g6-nanode-1" # shared 1 core, 1gb
# "g6-standard-1" # 1 core, 2gb
# "g6-standard-2" # 2 core, 4GB
# "g6-standard-4" # 4 core, 8GB
# "g6-standard-6" # 6 core, 16GB
# "g6-standard-8" # 8 core, 32GB
# ...

# Controller
variable "plan_controller" {
	type = string
	default = "g6-standard-4"
}
variable "plan_controller_disk" {
	type = number
	default = 163840 # Disk included with the 'g6-standard-4' plan.
}

# Node
variable "node_count" {
	type = number
	default = 1
}
# Used to create a consistent naming scheme for our nodes.
# This is for our recommend hostname scheme for nodes:
# * 3 digits for each node, following an identifier like 'node'.
# * 1st digit is the region (e.g. 1, 2, 3)
# * 2nd digit is the availability-zone
# * 3rd digit is the node.
variable "node_base_name" {
	type = string
	default = "10" # '10' would create node101, node102, node103, etc.
}
variable "plan_node" {
	type = string
	default = "g6-standard-2"
}
variable "plan_node_disk" {
	type = number
	default = 81920
}

# Backup
variable "plan_backup" {
	type = string
	default = "g6-standard-1"
}
variable "plan_backup_disk" {
	type = number
	default = 51200
}

# Prometheus & Loki
variable "dedicated_prom_server" {
	type = bool
	default = true # false = place loki/prom on the controller
}

variable "plan_prom" {
	type = string
	default = "g6-standard-2"
}

variable "plan_prom_disk" {
	type = number
	default = 81920
}
