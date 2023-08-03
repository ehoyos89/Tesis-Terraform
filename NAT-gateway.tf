resource "aws_eip" "eip_natgw1" {
  count = "1"
}


resource "aws_nat_gateway" "natgateway_1" {
  count = "1"
  allocation_id = aws_eip.eip_natgw1[count.index].id
  subnet_id = aws_subnet.PublicSubnet1.id
}