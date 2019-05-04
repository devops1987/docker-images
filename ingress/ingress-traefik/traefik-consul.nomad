job "ingress-traefik" {
  datacenters = ["dc1"]
  type = "system"

  group "ingress-traefik" {
    task "ingress-traefik" {
      driver = "docker"
      config {
        image = "traefik:v1.7-alpine"
        args  = ["-l debug", "--consulcatalog.endpoint=localhost:8500"]
        network_mode = "host"
      }

      resources {
        cpu    = 200
        memory = 128
        network {
          mbits = 20
          port "proxy" {
            static = 80
          }
          port "ui" {
            static = 8080
          }
        }
      }
    }
  }
}

