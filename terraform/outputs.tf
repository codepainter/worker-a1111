output "droplet-ip" {
  value = digitalocean_droplet.docker_builder.ipv4_address
}

