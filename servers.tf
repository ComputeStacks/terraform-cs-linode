resource "linode_stackscript" "cs_init" {
	label = "CS Init"
	description = "Pre init for ComputeStacks"
	script = <<EOF
#!/bin/bash
# <UDF name="new_hostname" label="New Hostname" example="node101" default="node101">
hostname $NEW_HOSTNAME && echo "$NEW_HOSTNAME" > /etc/hostname && echo "127.0.0.1 $NEW_HOSTNAME" >> /etc/hosts
yum -y update && yum -y install epel-release kernel-headers && yum -y install ansible
EOF
	images = ["linode/centos7"]
	rev_note = "initial version"
}

resource "linode_instance" "controller" {
	backups_enabled = false
  label = "controller"
  region = var.region
  type = var.plan_controller
	private_ip = true
  # authorized_keys = var.ssh_keys
	disk {
		label = "boot"
		size = var.plan_controller_disk
		image = "linode/centos7"
		authorized_users = var.ssh_users
		root_pass = random_string.server_password.result
		stackscript_id = linode_stackscript.cs_init.id
		stackscript_data = {
			"new_hostname" = "controller"
		}
	}

	config {
		label = "boot_config"
		kernel = "linode/grub2"
		devices {
			sda {
				disk_label = "boot"
			}
		}
	}
	boot_config_label = "boot_config"
}

resource "linode_instance" "node_cluster" {
	count = var.node_count

	backups_enabled = false
  label = format("node%s%s", var.node_base_name, count.index + 1)
  region = var.region
  type = var.plan_node
	private_ip = true

	disk {
		label = "boot"
		size = var.plan_node_disk
		image = "linode/centos7"
		authorized_users = var.ssh_users
		root_pass = random_string.server_password.result
		stackscript_id = linode_stackscript.cs_init.id
		stackscript_data = {
			"new_hostname" = format("node%s%s", var.node_base_name, count.index + 1)
		}
	}

	config {
		label = "boot_config"
		kernel = "linode/grub2"
		devices {
			sda {
				disk_label = "boot"
			}
		}
	}
	boot_config_label = "boot_config"

}

resource "linode_instance" "backup" {
	image = "linode/centos7"
	backups_enabled = false
  label = "backup"
  region = var.region
  type = var.plan_backup
	private_ip = true
	authorized_users = var.ssh_users
	root_pass = random_string.server_password.result
	stackscript_id = linode_stackscript.cs_init.id
  stackscript_data = {
    "new_hostname" = "backup"
  }
}
