### Local variables
locals {
  name        = "ubuntu-server"
  hostname    = "workstation-1"
  cores       = 2
  memory      = 4
  size        = 20
  type        = "network-ssd"
  platform_id = "standard-v3"
  image       = "ubuntu-2404-lts"
}

### Image VM from marketplace
data "yandex_compute_image" "image" {
  family = local.image
}

### Instance vm
resource "yandex_compute_instance" "this" {
  name                      = local.name
  hostname                  = local.hostname
  allow_stopping_for_update = true
  platform_id               = local.platform_id
  zone                      = var.zone

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.id
      type     = local.type
      size     = local.size
    }
  }

  network_interface {
    subnet_id = module.vpc-single-zone.subnet_id
    nat       = true

    security_group_ids = [
      module.vpc-single-zone.ids_security_group
    ]
  }

  resources {
    cores  = local.cores
    memory = local.memory
  }

  metadata = {
    ssh-keys = "${var.user_vm}:${file("${var.public_key}")}"
  }

  service_account_id = yandex_iam_service_account.sa.id

  scheduling_policy {
    preemptible = true
  }
}


