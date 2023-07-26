# Crear un grupo de seguridad para el load balancer
resource "aws_security_group" "elb_sg" {
    name = "elb_sg"
    description = "Grupo de seguridad para el load balancer"
    vpc_id = aws_vpc.DataredVPC.id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    } 
}

# Crear un grupo de seguridad para las instancias del servicio web
resource "aws_security_group" "web_sg" {
    name = "web_sg"
    description = "Grupo de seguridad para las instancias del servicio web"
    vpc_id = aws_vpc.DataredVPC.id
    depends_on = [aws_vpc.DataredVPC]

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        description = "Permitir el trafico HTTP desde el load balancer"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        description = "Permitir el trafico SSH desde la red de la empresa"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443           
        protocol = "tcp"
        description = "Permitir el trafico HTTPS desde la red de la empresa"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Crear un grupo de seguridad para las instancias de base de datos
resource "aws_security_group" "database" {
    name = "database"
    description = "enable access to database"
    vpc_id = aws_vpc.DataredVPC.id
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [ aws_security_group.web_sg.id ]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }
}