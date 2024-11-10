### Data sources
data "yandex_client_config" "client" {}

### Local variables
locals {
  user = "web-serfer"

  # vm resources
  cores  = 2
  memory = 4
  size   = 40
  type   = "network-ssd"
}

### Image vm from marketplace
data "yandex_compute_image" "coi-image" {
  family = "container-optimized-image"
}

### Instance vm
resource "yandex_compute_instance" "instance-based-on-coi" {
  name                      = "linux-vm"
  hostname                  = "linux-coi"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = var.zone

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.coi-image.id
      type     = local.type
      size     = local.size
    }
  }

  network_interface {
    subnet_id = module.vpc-single-zone.subnet_id
    nat       = true
  }

  resources {
    cores  = local.cores
    memory = local.memory
  }

  metadata = {
    user-data = data.template_file.cloud-config.rendered
  }

  service_account_id = yandex_iam_service_account.instance-sa.id

  ## прерываемая 
  scheduling_policy {
    preemptible = true
  }
}

### Metadata vm
data "template_file" "cloud-config" {
  template = file("${path.module}/cloud_config.tpl")
  vars = {
    user    = local.user
    ssh-key = file("C:/Users/Администратор/.ssh/id_rsa.pub")
  }
}

### Service account
resource "yandex_iam_service_account" "instance-sa" {
  name = "instance-sa"
}

### Instance vm access
resource "yandex_compute_instance_iam_binding" "compute-admin" {
  instance_id = yandex_compute_instance.instance-based-on-coi.id

  role = "compute.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.instance-sa.id}",
  ]
}
