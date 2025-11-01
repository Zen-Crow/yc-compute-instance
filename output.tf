output "ssh_connection" {
  value = "ssh ${var.user_vm}@${yandex_compute_instance.this.network_interface.0.nat_ip_address}"
}

output "fqdn" {
  value = "fqdn: ${yandex_compute_instance.this.fqdn}"
}
