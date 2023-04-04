terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex",
      version = "~> 0.88"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.23"
    }
  }
}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone      = var.yandex_zone
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://api.datadoghq.eu/"
}
