### Service Account
resource "yandex_iam_service_account" "sa" {
  name = "instance-sa"
}

### Instance Role Access
resource "yandex_compute_instance_iam_binding" "admin" {
  instance_id = yandex_compute_instance.this.id
  role = "compute.admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
}
