resource "aws_internet_gateway" "DataredGateway" {
    vpc_id = aws_vpc.DataredVPC.id
    }