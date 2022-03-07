variable "linode_api_key" {
	type = string
}
variable "ssh_users" {
	type = list
	default = ["computestacks"]
}

##
# Linode Image
variable "debian_image" {
	type = string
	default = "linode/debian11"
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
variable "plan_metrics" {
	type = string
	default = "g6-standard-2"
}

variable "plan_metrics_disk" {
	type = number
	default = 81920
}

# Registry
variable "plan_registry" {
	type = string
	default = "g6-standard-2"
}

variable "plan_registry_disk" {
	type = number
	default = 81920
}

##
# ComputeStacks
variable "region_name" {
	type = string
	default = "linode"
}
variable "cs_app_url" {
	type = string
	default = "a.linode"
}
variable "cs_currency" {
	type = string
	default = "USD"
}
variable "cs_network_range" {
	type = string
	default = "10.100.0.0/21"
}
variable "cs_portal_domain" {
	type = string
	default = "portal.linode"
}
variable "cs_registry_domain" {
	type = string
	default = "cr.linode"
}
variable "cs_metrics_domain" {
	type = string
	default = "metrics.linode"
}

##
# DNS
variable "zone_name" {
	type = string
}

# Admin User
variable "cs_admin_email" {
	type = string
	default = "root@localhost"
}

##
# PowerDNS
variable "plan_nameserver" {
	type = string
	default = "g6-standard-1"
}
variable "plan_nameserver_disk" {
	type = number
	default = 51200
}
variable "region_nstwo" {
	type = string
	default = "us-east"
}

variable "primary_nameserver_zone" {
	type = string
	default = ""
}

variable "secondary_nameserver_zone" {
	type = string
	default = ""
}
variable "primary_nameserver_domain" {
	type = string
	default = ""
}

variable "secondary_nameserver_domain" {
	type = string
	default = ""
}
