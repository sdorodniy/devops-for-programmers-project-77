resource "yandex_compute_instance" "app-vm-1" {
  name = "app-vm-1"
  platform_id = "standard-v1"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 1
    gpus   = 0
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd8emvfmfoaordspe1jr"
      size     = 15
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet-1.id
    ipv4           = true
    nat            = true
    nat_ip_address = var.app-vm-1_public_ip
  }

  metadata = {
    ssh-keys = "${var.app-vm-user}:${var.ssh_key}"
  }
}

resource "yandex_compute_instance" "app-vm-2" {
  name = "app-vm-2"
  platform_id = "standard-v1"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 1
    gpus   = 0
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd8emvfmfoaordspe1jr"
      size     = 15
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet-1.id
    ipv4           = true
    nat            = true
    nat_ip_address = var.app-vm-2_public_ip
  }

  metadata = {
    ssh-keys = "${var.app-vm-user}:${var.ssh_key}"
  }
}