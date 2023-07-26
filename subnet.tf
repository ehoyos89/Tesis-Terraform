# Paso 2: Crear las subredes públicas
resource "aws_subnet" "PublicSubnet1" {
    vpc_id = aws_vpc.DataredVPC.id
    cidr_block = "10.0.0.16/28"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "PublicSubnet2" {
    vpc_id = aws_vpc.DataredVPC.id
    cidr_block = "10.0.0.32/28"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "PublicSubnet3" {
    vpc_id = aws_vpc.DataredVPC.id
    cidr_block = "10.0.0.48/28"
    availability_zone = "us-east-1c"
    map_public_ip_on_launch = true
}

# Paso 3: Crear las subredes privadas
resource "aws_subnet" "PrivateSubnet1" {
    vpc_id = aws_vpc.DataredVPC.id
    cidr_block = "10.0.0.64/28"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "PrivateSubnet2" {
    vpc_id = aws_vpc.DataredVPC.id
    cidr_block = "10.0.0.80/28"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
}


# Crear un subnet group para la base de datos
resource "aws_db_subnet_group" "DataredDBSubnetGroup" {
    name = "database"
    description = "Subnet group para la base de datos"
    subnet_ids = [
        aws_subnet.PrivateSubnet1.id,
        aws_subnet.PrivateSubnet2.id
    ]
}



