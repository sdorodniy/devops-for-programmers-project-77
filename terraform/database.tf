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