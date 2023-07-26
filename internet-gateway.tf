# Paso 4: Crear la puerta de enlace a Internet
resource "aws_internet_gateway" "DataredGateway" {
    vpc_id = aws_vpc.DataredVPC.id
    }