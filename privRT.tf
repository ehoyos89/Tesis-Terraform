# Crear una ruta privada para la subred privada 1
resource "aws_route_table" "privateRT1" {
    count = "1"
    vpc_id = aws_vpc.DataredVPC.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.natgateway_1[count.index].id
     }     
}

# Crear una asociación de tabla de enrutamiento para la subred privada 1
resource "aws_route_table_association" "privateRT1_to_natgw1" {
    count = "1"
    subnet_id = aws_subnet.PrivateSubnet1.id
    route_table_id = aws_route_table.privateRT1[count.index].id  
}

