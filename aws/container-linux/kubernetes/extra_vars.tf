// usage az-zone-match = ["*az1"]
variable "az-zone-match" {
  default = ["eu-west-1a"]
}

variable "subnet_size" {
  default = 2
}

variable "nlb_eip_id" {
  default = null
}
