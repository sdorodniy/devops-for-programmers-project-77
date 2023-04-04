variable "yandex_cloud_id" {
  description = "Ynadex cloud provider cloud ID"
  type        = string
}
variable "yandex_folder_id" {
  description = "Ynadex cloud provider folder ID"
  type        = string
}
variable "yandex_zone" {
  description = "Ynadex cloud zone"
  type        = string
}
variable "yandex_token" {
  description = "Ynadex cloud token"
  type        = string
  sensitive   = true
}
variable "app-vm-1_public_ip" {
  description = "Public IP for APP 1 instance"
  type        = string
}
variable "app-vm-2_public_ip" {
  description = "Public IP for APP 2 instance"
  type        = string
}
variable "ssh_key" {
  description = "SSH key"
  type        = string
  sensitive   = true
}
variable "db_user" {
  description = "Data base user"
  type        = string
}
variable "db_password" {
  description = "Data base user passowrd"
  type        = string
  sensitive   = true
}