resource "docker_image" "mongo" {
  name = "mongo:6"
}

resource "docker_container" "mongodb" {
  name  = "mongodb"
  image = docker_image.express_app.name
  networks_advanced {
    name = docker_network.sre_net.name
  }
  ports {
    internal = 27017
    external = 27017
  }
  volumes {
    container_path = "/data/db"
    host_path = abspath("${path.module}/mongo_data")
  }
}
