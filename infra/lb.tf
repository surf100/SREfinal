resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_lb" {
  name  = "nginx-lb"
  image = docker_image.express_app.name
  networks_advanced {
    name = docker_network.sre_net.name
  }
  ports {
    internal = 80
    external = 8080
  }
  volumes {
    container_path = "/etc/nginx/nginx.conf"
    host_path = abspath("${path.module}/nginx.conf")
    read_only      = true
  }
}
