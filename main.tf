terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 1.13"
    }
  }
}
provider "linode" {
	token = var.linode_api_key
}

resource "random_string" "server_password" {
    length  = 24
    special = true
}

resource "random_string" "pg_password" {
    length  = 24
    special = false
}
resource "random_string" "loki_password" {
    length  = 24
    special = false
}
resource "random_string" "prometheus_password" {
    length  = 24
    special = false
}
resource "random_string" "backup_key" {
    length  = 24
    special = true
}