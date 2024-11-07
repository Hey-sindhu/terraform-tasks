resource "docker_container" "c1" {
  image = "tomcat:9.0"
  name  = "tom_con"
  ports {

    internal = 8080
    external = 8089
  }
  command = ["bin/catalina.sh", "run"]
}

resource "docker_container" "c2" {
  image = "nginx:latest"
  name  = "tom_nginx"
  ports {

    internal = 8080
    external = 8090
  }
}
