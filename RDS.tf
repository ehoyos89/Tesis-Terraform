# Crear base de datos
resource "aws_db_instance" "db_instance" {
    engine = "mysql"
    engine_version = "8.0.31"
    multi_az = true
    username = "ITadmin"
    password = "Datared2021"
    identifier = "datared-db"
    instance_class = "db.t2.micro"
    allocated_storage = 20
    db_subnet_group_name = aws_db_subnet_group.DataredDBSubnetGroup.name
    vpc_security_group_ids = [aws_security_group.database.id]
    skip_final_snapshot = true
    availability_zone = "us-east-1a"
    db_name = "appdb"

}