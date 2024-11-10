variable "cloud_id" {
  type    = string
  default = null
}

variable "folder_id" {
  type    = string
  default = null
}

variable "zone" {
  description = "Yandex Cloud zone."
  type    = string
  default = "ru-central1-a"
}

variable "token" {
  description = "Yandex Cloud Iam token."
  type    = string
  default = null
}

variable "name_prefix" {
  description = "Name prefix for project."
  type        = string
  default     = "cloud"
}

variable "vpc_network_name" {
  description = "Name of the VPC network."
  type        = string
  default     = null
}
