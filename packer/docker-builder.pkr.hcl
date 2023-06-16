variable "do_token" {
  type    = string
  default = "${env("DIGITALOCEAN_TOKEN")}"
}

variable "version" {
  type    = string
  default = "latest"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "digitalocean" "docker_builder" {
  api_token     = "${var.do_token}"
  droplet_name  = "docker-builder-${var.version}"
  image         = "ubuntu-22-04-x64"
  region        = "sgp1"
  size          = "s-1vcpu-512mb-10gb"
  snapshot_name = "docker-builder-${var.version}-${local.timestamp}"
  ssh_username  = "root"
}

build {
  sources = ["source.digitalocean.docker_builder"]

  provisioner "shell" {
    script = "scripts/common-install.sh"
  }

  provisioner "shell" {
    script = "scripts/docker-install.sh"
  }
}
