# Paso 1: Crear la VPC
resource "aws_vpc" "DataredVPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
}
