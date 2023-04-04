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

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

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

resource "yandex_mdb_mysql_cluster" "db-cluster" {
    name        = "db"
    environment = "PRODUCTION"
    network_id  = yandex_vpc_network.network-1.id
    version     = "8.0"
  
    resources {
      resource_preset_id = "b1.nano"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  
    mysql_config = {
      sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
      default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    }
  
    host {
      zone      = var.yandex_zone
      subnet_id = yandex_vpc_subnet.subnet-1.id
    }

    timeouts {
      create = "120m"
    }
  }
  
  resource "yandex_mdb_mysql_database" "db" {
    cluster_id = yandex_mdb_mysql_cluster.db-cluster.id
    name       = var.db_name
  }
  
  resource "yandex_mdb_mysql_user" "db-user" {
    cluster_id = yandex_mdb_mysql_cluster.db-cluster.id
    name       = var.db_user
    password   = var.db_password
  
    permission {
      database_name = yandex_mdb_mysql_database.db.name
      roles         = ["ALL"]
    }
  }