resource "yandex_lb_network_load_balancer" "network-load-balancer" {
  name = "network-load-balancer"

  listener {
    name        = "listener-80"
    port        = 80
    target_port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
    listener {
    name        = "listener-443"
    port        = 443
    target_port = 443
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.target-group.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "target-group" {
  name      = "target-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address   = yandex_compute_instance.app-vm-1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address   = yandex_compute_instance.app-vm-2.network_interface.0.ip_address
  }
}
