terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex",
      version = "~> 0.88"
    }
  }
}

provider "yandex" {
  token     = var.yandex_token
  #token     = trimspace(file("token.txt"))
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone      = var.yandex_zone
}
