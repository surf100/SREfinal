resource "docker_image" "express_app" {
  name = "yourname/express-app:latest"
  build {
    context = "../" # adjust path to your app
  }
}

resource "docker_container" "app1" {
  name  = "app1"
  image = docker_image.express_app.name
  networks_advanced {
    name = docker_network.sre_net.name
  }
  ports {
    internal = 3000
    external = 3001
  }
}

resource "docker_container" "app2" {
  name  = "app2"
  image = docker_image.express_app.name
  networks_advanced {
    name = docker_network.sre_net.name
  }
  ports {
    internal = 3000
    external = 3002
  }
}
