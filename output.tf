output "ssh_connection" {
    value = "ssh ${local.user}@${yandex_compute_instance.instance-based-on-coi.network_interface.0.nat_ip_address}"
}
