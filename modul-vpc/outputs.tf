output "subnet_id" {
  value = yandex_vpc_subnet.this.id
}

output "ids_security_group" {
  value = yandex_vpc_security_group.group.id
}