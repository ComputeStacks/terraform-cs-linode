resource "local_file" "inventory" {
	content = templatefile("outputs/inventory.yml.tmpl", {
		node_count = length(linode_instance.node_cluster),
		metrics_count = length(linode_instance.metrics),
		registry_count = length(linode_instance.registries),
		registry_public = linode_instance.registries.*.ip_address,
		registry_private = linode_instance.registries.*.private_ip_address,
		nodes_public = linode_instance.node_cluster.*.ip_address,
		nodes_private = linode_instance.node_cluster.*.private_ip_address,
		metrics_public = linode_instance.metrics.*.ip_address,
		metrics_private = linode_instance.metrics.*.private_ip_address,
		controller_public = linode_instance.controller.ip_address,
		controller_private = linode_instance.controller.private_ip_address,
		backup_public = linode_instance.backup.ip_address,
		backup_private = linode_instance.backup.private_ip_address,
		pg_pass = random_string.pg_password.result,
		loki_pass = random_string.loki_password.result,
		prom_pass = random_string.prometheus_password.result,
		backup_key = random_string.backup_key.result,
		app_id = random_string.app_id.result,
		network_name = lower(random_string.network_name.result),
		network_range = var.cs_network_range,
		region_name = var.region_name,
		currency = var.cs_currency,
		zone_name = var.zone_name,
		cs_app_url = format("%s.%s", var.cs_app_url, var.zone_name),
		cs_portal_domain = format("%s.%s", var.cs_portal_domain, var.zone_name),
		cs_registry_domain = format("%s.%s", var.cs_registry_domain, var.zone_name),
		cs_metrics_domain = format("%s.%s", var.cs_metrics_domain, var.zone_name),
		license_key = var.license_key,
		use_zerossl = var.use_zerossl,
		acme_challenge_method = var.acme_challenge_method,
		acme_cf_account = var.acme_cf_account,
		acme_cf_token = var.acme_cf_token,
		default_image = var.linode_default_image,
		cs_admin_create = var.cs_admin_create,
		cs_admin_email = var.cs_admin_email,
		cs_admin_password = random_string.cs_admin_password.result
	})
	filename = "result/inventory.yml"
}

resource "local_file" "dns_settings" {
	content = templatefile("outputs/dns_settings.txt.tmpl", {
		cs_app_url = format("%s.%s", var.cs_app_url, var.zone_name),
		cs_portal_domain = format("%s.%s", var.cs_portal_domain, var.zone_name),
		cs_registry_domain = format("%s.%s", var.cs_registry_domain, var.zone_name),
		cs_metrics_domain = format("%s.%s", var.cs_metrics_domain, var.zone_name),
		registry_count = length(linode_instance.registries),
		metrics_count = length(linode_instance.metrics),
		nodes_public = linode_instance.node_cluster.*.ip_address,
		controller_public = linode_instance.controller.ip_address,
		metrics_public = linode_instance.metrics.*.ip_address,
		registry_public = linode_instance.registries.*.ip_address
	})
	filename = "result/dns_settings.txt"
}
