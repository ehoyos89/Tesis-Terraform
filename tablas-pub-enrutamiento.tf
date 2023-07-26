# Paso 5: Crear las tablas de enrutamiento para las subredes públicas
resource "aws_route_table" "PublicRT" {
    vpc_id = aws_vpc.DataredVPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.DataredGateway.id
  }
}


# Paso 6: Asociar las subredes públicas a la tabla de enrutamiento
resource "aws_route_table_association" "Public1RTassociation" {
    subnet_id = aws_subnet.PublicSubnet1.id
    route_table_id = aws_route_table.PublicRT.id  
}

resource "aws_route_table_association" "Public2RTassociation" {
    subnet_id = aws_subnet.PublicSubnet2.id
    route_table_id = aws_route_table.PublicRT.id  
}

resource "aws_route_table_association" "Public3RTassociation" {
    subnet_id = aws_subnet.PublicSubnet3.id
    route_table_id = aws_route_table.PublicRT.id  
}