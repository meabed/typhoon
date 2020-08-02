// usage az-zone-match = ["*az1"]
variable "az-zone-match" {
  default = ["*"]
}

data "aws_availability_zones" "all" {
  filter {
    name = "zone-id"
    values = var.az-zone-match
  }
}

resource "aws_subnet" "public" {
  \\ Increase number of IPV4 to fix Calico IP-Pool exhaust issue
  cidr_block                      = cidrsubnet(var.host_cidr, 2, count.index)
}
