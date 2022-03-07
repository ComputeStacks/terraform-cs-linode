resource "linode_stackscript" "cs_init_debian" {
  label       = "CS Init (Debian)"
  description = "Pre init for ComputeStacks"
  script      = <<EOF
#!/bin/bash
# <UDF name="new_hostname" label="New Hostname" example="node101" default="node101">
hostname $NEW_HOSTNAME && echo "127.0.0.1  $NEW_HOSTNAME" >> /etc/hosts
hostnamectl set-hostname $NEW_HOSTNAME
apt update && apt -y install openssl ca-certificates linux-headers-amd64 python3 python3-pip python3-openssl python3-apt && pip3 install ansible
EOF
  images      = ["linode/debian11"]
  rev_note    = "initial version"
}

resource "linode_instance" "controller" {
  backups_enabled = false
  label           = "controller"
  region          = var.region
  type            = var.plan_controller
  private_ip      = true
  disk {
    label            = "boot"
    size             = var.plan_controller_disk
    image            = var.debian_image
    authorized_users = var.ssh_users
    root_pass        = random_string.server_password.result
    stackscript_id   = linode_stackscript.cs_init_debian.id
    stackscript_data = {
      "new_hostname" = "controller"
    }
  }

  config {
    label  = "boot_config"
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
  label           = format("node%s%s", var.node_base_name, count.index + 1)
  region          = var.region
  type            = var.plan_node
  private_ip      = true

  disk {
    label            = "boot"
    size             = var.plan_node_disk
    image            = var.debian_image
    authorized_users = var.ssh_users
    root_pass        = random_string.server_password.result
    stackscript_id   = linode_stackscript.cs_init_debian.id
    stackscript_data = {
      "new_hostname" = format("node%s%s", var.node_base_name, count.index + 1)
    }
  }

  config {
    label  = "boot_config"
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
  image            = var.debian_image
  backups_enabled  = false
  label            = "backup"
  region           = var.region
  type             = var.plan_backup
  private_ip       = true
  authorized_users = var.ssh_users
  root_pass        = random_string.server_password.result
  stackscript_id   = linode_stackscript.cs_init_debian.id
  stackscript_data = {
    "new_hostname" = "backup"
  }
}

resource "linode_instance" "metrics" {
  backups_enabled = false
  label           = "metrics"
  region          = var.region
  type            = var.plan_metrics
  private_ip      = true

  disk {
    label            = "boot"
    size             = var.plan_metrics_disk
    image            = var.debian_image
    authorized_users = var.ssh_users
    root_pass        = random_string.server_password.result
    stackscript_id   = linode_stackscript.cs_init_debian.id
    stackscript_data = {
      "new_hostname" = "metrics"
    }
  }
  config {
    label  = "boot_config"
    kernel = "linode/grub2"
    devices {
      sda {
        disk_label = "boot"
      }
    }
  }
  boot_config_label = "boot_config"

}

resource "linode_instance" "registry" {
  backups_enabled = false
  label           = "registry"
  region          = var.region
  type            = var.plan_registry
  private_ip      = true

  disk {
    label            = "boot"
    size             = var.plan_registry_disk
    image            = var.debian_image
    authorized_users = var.ssh_users
    root_pass        = random_string.server_password.result
    stackscript_id   = linode_stackscript.cs_init_debian.id
    stackscript_data = {
      "new_hostname" = "registry"
    }
  }

  config {
    label  = "boot_config"
    kernel = "linode/grub2"
    devices {
      sda {
        disk_label = "boot"
      }
    }
  }
  boot_config_label = "boot_config"

}

resource "linode_instance" "nsone" {
  backups_enabled = false
  label           = "ns1"
  region          = var.region
  type            = var.plan_nameserver
  private_ip      = true

  disk {
    label            = "boot"
    size             = var.plan_nameserver_disk
    image            = var.debian_image
    authorized_users = var.ssh_users
    root_pass        = random_string.server_password.result
    stackscript_id   = linode_stackscript.cs_init_debian.id
    stackscript_data = {
      "new_hostname" = "ns1"
    }
  }

  config {
    label  = "boot_config"
    kernel = "linode/grub2"
    devices {
      sda {
        disk_label = "boot"
      }
    }
  }
  boot_config_label = "boot_config"

}

resource "linode_instance" "nstwo" {
  backups_enabled = false
  label           = "ns2"
  region          = var.region_nstwo
  type            = var.plan_nameserver
  private_ip      = true

  disk {
    label            = "boot"
    size             = var.plan_nameserver_disk
    image            = var.debian_image
    authorized_users = var.ssh_users
    root_pass        = random_string.server_password.result
    stackscript_id   = linode_stackscript.cs_init_debian.id
    stackscript_data = {
      "new_hostname" = "ns2"
    }
  }

  config {
    label  = "boot_config"
    kernel = "linode/grub2"
    devices {
      sda {
        disk_label = "boot"
      }
    }
  }
  boot_config_label = "boot_config"

}
