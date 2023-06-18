terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

locals {
  snapshot_id = var.snapshot_id
  region      = var.region
}

resource "digitalocean_ssh_key" "docker_builder" {
  name       = "docker_builder"
  public_key = file(var.pub_key)
}


resource "digitalocean_droplet" "docker_builder" {
  image  = local.snapshot_id
  name   = "docker-builder"
  region = local.region
  size   = "s-4vcpu-8gb"
  ssh_keys = [
    digitalocean_ssh_key.docker_builder.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello World'",
      "fish -v",
      "docker -v",
      "git clone https://github.com/codepainter/worker-a1111.git",
      "wget -qO- https://repos-droplet.digitalocean.com/install.sh | sudo bash"
    ]
  }
}
