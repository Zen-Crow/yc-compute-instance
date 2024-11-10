### Datasource ###
data "yandex_client_config" "client" {}

### Local variables ###
locals {
  network_name = var.vpc_network_name != null ? var.vpc_network_name : "${var.name_prefix}"
}

### Network ###
resource "yandex_vpc_network" "this" {
  name = local.network_name
}

### Gateway ###
resource "yandex_vpc_gateway" "gt" {
  name      = "${local.network_name}-gt"
  folder_id = var.folder_id
  shared_egress_gateway {}
}

### Route table ###
resource "yandex_vpc_route_table" "rt" {
  name       = "${local.network_name}-rt"
  network_id = yandex_vpc_network.this.id
  folder_id  = var.folder_id
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.gt.id
  }
}

### Subnets ###
resource "yandex_vpc_subnet" "this" {
  name           = "${local.network_name}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}


### Security group with rules ###
resource "yandex_vpc_security_group" "group" {
  name       = "${local.network_name}-sg"
  network_id = yandex_vpc_network.this.id
  folder_id  = var.folder_id

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "Grafana"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 3000
  }

  ingress {
    protocol       = "TCP"
    description    = "Prometheus"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 9090
  }

  ingress {
    protocol       = "ICMP"
    description    = "Allow Echo request - ICMP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  egress {
    protocol       = "ANY"
    description    = "To internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

