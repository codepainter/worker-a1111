variable "do_token" {
  type        = string
  description = "(Required) This is the DigitalOcean API token."
}

variable "snapshot_id" {
  type        = string
  description = "(Required) The Droplet image ID or slug. This could be either image ID or droplet snapshot ID."
}

variable "region" {
  type        = string
  default     = "sgp1"
  description = "(Required) The region to start the droplet in."
}

variable "pvt_key" {
  type        = string
  description = "(Required) The private key to use for SSH access to the droplet."
  default     = "~/.ssh/id_rsa"
}

variable "pub_key" {
  type        = string
  description = "(Required) The public key to use for SSH access to the droplet."
  default     = "~/.ssh/id_rsa.pub"
}

variable "docker_username" {
  type        = string
  description = "(Required) The username to use for docker login."
}

variable "docker_password" {
  type        = string
  description = "(Required) The password to use for docker login."
}

variable "docker_tag" {
  type        = string
  description = "(Required) The docker tag to use for docker login."
}
