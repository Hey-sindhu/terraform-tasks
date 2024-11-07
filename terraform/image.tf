resource "docker_image" "ubuntu1" {
  name = "ubuntu"
}

resource "docker_image" "tom1" {
  name = "tomcat:9.0"
}

resource "docker_image" "ngnix" {
  name = "nginx:latest"
}
