resource "local_file" "Inventory" {
	content = templatefile("inventory.yml.tmpl", {
		nodes = linode_instance.node_cluster.*.label,
		nodes_public = linode_instance.node_cluster.*.ip_address,
		nodes_private = linode_instance.node_cluster.*.private_ip_address,
		controller_public = linode_instance.controller.ip_address,
		controller_private = linode_instance.controller.private_ip_address,
		backup_public = linode_instance.backup.ip_address,
		backup_private = linode_instance.backup.private_ip_address,
		pg_pass = random_string.pg_password.result,
		loki_pass = random_string.loki_password.result,
		prom_pass = random_string.prometheus_password.result,
		backup_key = random_string.backup_key.result
	})
	filename = "inventory.yml"
}
