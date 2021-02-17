resource "linode_domain_record" "zone_portal" {
    count = var.use_linode_ns ? 1 : 0
    domain_id = var.linode_zone_id
    name = var.cs_portal_domain
    record_type = "A"
    ttl_sec = var.zone_ttl
    target = linode_instance.controller.ip_address
}
resource "linode_domain_record" "zone_registry" {
    count = var.use_linode_ns ? 1 : 0
    domain_id = var.linode_zone_id
    name = var.cs_registry_domain
    record_type = "A"
    ttl_sec = var.zone_ttl
    target = var.dedicated_registry_server ? linode_instance.registries.*.ip_address[0] : linode_instance.controller.ip_address
}
resource "linode_domain_record" "zone_metrics" {
    count = var.use_linode_ns ? 1 : 0
    domain_id = var.linode_zone_id
    name = var.cs_metrics_domain
    record_type = "A"
    ttl_sec = var.zone_ttl
    target = var.dedicated_metrics_server ? linode_instance.metrics.*.ip_address[0] : linode_instance.controller.ip_address
}
resource "linode_domain_record" "zone_app" {
    count = var.use_linode_ns ? 1 : 0
    domain_id = var.linode_zone_id
    name = var.cs_app_url
    record_type = "A"
    ttl_sec = var.zone_ttl
    target = linode_instance.node_cluster.0.ip_address
}
resource "linode_domain_record" "zone_app_wildcard" {
    count = var.use_linode_ns ? 1 : 0
    domain_id = var.linode_zone_id
    name = format("*.%s", var.cs_app_url)
    record_type = "CNAME"
    ttl_sec = var.zone_ttl
    target = format("%s.%s", var.cs_app_url, var.zone_name)
}
