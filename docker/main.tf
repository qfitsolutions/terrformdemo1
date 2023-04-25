terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "node-js-app" {
  name = "nginx:latest"
}


resource "docker_container" "foo" {
  image = docker_image.node-js-app.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 49160
  }
}
