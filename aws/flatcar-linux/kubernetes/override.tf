variable "az-zone-match" {
  default = ["eu-west-1a"]
}

variable "subnet_size" {
  default = 2
}

data "aws_availability_zones" "all" {
  filter {
    name = "zone-name"
    values = var.az-zone-match
  }
}

resource "aws_subnet" "public" {
  // Increase number of IPV4 to fix Calico IP-Pool exhaust issue
  count = var.subnet_size
  availability_zone = data.aws_availability_zones.all.names[0]
  // 10.0.3.0/16 => (2) 10.0.3.0/18 & 10.0.3.0/18
  cidr_block        = cidrsubnet(var.host_cidr, 2, count.index)
}


# Network Load Balancer for apiservers and ingress
resource "aws_lb" "nlb" {
  subnets = null
  subnet_mapping {
    subnet_id = aws_subnet.public.0.id
    allocation_id = aws_eip.nlp_eip.id
  }
}

resource "aws_route_table_association" "public" {
  count = var.subnet_size
}