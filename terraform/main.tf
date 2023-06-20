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
  snapshot_id     = var.snapshot_id
  region          = var.region
  docker_username = var.docker_username
  docker_password = var.docker_password
  docker_tag      = var.docker_tag
}

resource "digitalocean_ssh_key" "docker_builder" {
  name       = "docker_builder"
  public_key = file(var.pub_key)
}


resource "digitalocean_droplet" "docker_builder" {
  image  = local.snapshot_id
  name   = "worker-builder"
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

  provisioner "file" {
    content     = local.docker_password
    destination = "/var/docker-password.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello World'",
      "fish -v",
      "docker -v",
    ]
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "cat /var/docker-password.txt | docker login --username ${local.docker_username} --password-stdin",
  #     "pwd && ls -haltr",
  #     "git clone https://github.com/codepainter/worker-a1111.git && cd worker-a1111 && git checkout ${local.docker_tag} && ./build.sh ${local.docker_tag}",
  #     "pwd && ls -haltr",
  #     # "wget -qO- https://repos-droplet.digitalocean.com/install.sh | sudo bash"
  #     "echo 'Build ${local.docker_tag} Complete!'"
  #   ]
  # }
}
