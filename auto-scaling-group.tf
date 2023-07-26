# Crear un grupo de Auto Scaling
resource "aws_autoscaling_group" "ASG" {
    name = "DataredASG"
    desired_capacity = 1
    max_size = 3
    min_size = 1
    force_delete = true
    depends_on = [aws_lb.ALB]
    target_group_arns = [aws_lb_target_group.TG.arn]
    health_check_type = "EC2"
    launch_configuration = aws_launch_configuration.DataredLaunchConfig.name
    vpc_zone_identifier = [aws_subnet.PublicSubnet1.id, aws_subnet.PublicSubnet2.id, aws_subnet.PublicSubnet3.id]
    tag {
        key = "Name"
        value = "DataredASG"
        propagate_at_launch = true
    }
  
}


#Crear un auto scaling policy
resource "aws_autoscaling_policy" "ASGPolicy" {
    name = "DataredASGPolicy"
    policy_type = "TargetTrackingScaling"
    estimated_instance_warmup = 300
    autoscaling_group_name = aws_autoscaling_group.ASG.name
    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 80.0
    }
}

# Crear Target Group
resource "aws_lb_target_group" "TG" {
    name = "DataredTG"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.DataredVPC.id
    depends_on = [aws_vpc.DataredVPC]
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        interval = 30
        path = "/"
        port = "80"
        protocol = "HTTP"
        matcher = "200-299"
    }
  
}