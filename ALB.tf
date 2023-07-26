# Crear un Apliacion Load Balancer
resource "aws_lb" "ALB" {
    name = "DataredALB"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.elb_sg.id]
    subnets = [aws_subnet.PublicSubnet1.id, aws_subnet.PublicSubnet2.id, aws_subnet.PublicSubnet3.id]
    enable_deletion_protection = false
    enable_http2 = true
    enable_cross_zone_load_balancing = true
    ip_address_type = "ipv4"
    tags = {
        Name = "DataredALB"
    }
  
}

# Crear Listeners
resource "aws_lb_listener" "HTTP" {
    load_balancer_arn = aws_lb.ALB.arn
    port = 80
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.TG.arn

    }
}