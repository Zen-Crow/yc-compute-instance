variable "cloud_id" {
  type        = string
  description = "Yandex Cloud id"
  default     = null
}

variable "folder_id" {
  type        = string
  description = "Yandex Folder id"
  default     = null
}

variable "yc_token" {
  type        = string
  description = "Yandex Cloud token"
  default     = null
}

variable "zone" {
  type        = string
  description = "Yandex Cloud zone"
  default     = "ru-central1-a"
}
