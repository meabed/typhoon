// usage az-zone-match = ["*az1"]
variable "az-zone-match" {
  default = ["eu-west-1a"]
}

variable "subnet_size" {
  default = 2
}

// extra resources
resource "aws_eip" "nlp_eip" {
  vpc = true
  associate_with_private_ip = cidrhost(aws_subnet.public.0.cidr_block, 1)
}

// outputs
output "aws_eip_nlp_public_ip" {
  value = aws_eip.nlp_eip.public_ip
}

output "aws_eip_nlp_private_ip" {
  value = aws_eip.nlp_eip.private_ip
}

output "aws_route_tables_ids" {
  value = [
    aws_route_table.default.id
  ]
}
