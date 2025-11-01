variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
  default     = null
}

variable "zone" {
  type        = string
  description = "Yandex Cloud Zone"
  default     = "ru-central1-a"
}

variable "user_vm" {
  type        = string
  default     = "ubuntu"
  description = "User Name for SSH Connection"
}

variable "public_key" {
  type        = string
  default     = "C:/Users/Администратор/.ssh/id_rsa.pub"
  description = "SSH Public key path"
}
