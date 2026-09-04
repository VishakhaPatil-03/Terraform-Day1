data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "sg" {
    name = "day3_sg"
    description = "Security group for day3 instance"
    vpc_id = data.aws_vpc.default.id
   
   ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
    from_port = 80
    to_port =80
    protocol ="tcp"
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

resource "aws_launch_template" "my-launch-template"{
     name  = "my-template"
     image_id = var.aws_ami
     instance_type = var.instance_type
     key_name = "kapishh"
     vpc_security_group_ids = [aws_security_group.sg.id]
     user_data = filebase64("/home/ubuntu/Terraform-Day1/Day3-ASG/user_data.sh")
    tags = {
        name = "my-launch-template"
    }
}

resource "aws_lb_target_group" "my-target-group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb" "my-load-balancer" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = data.aws_subnets.default.ids

  enable_deletion_protection = false
}

resource "aws_lb_listener" "my-listener" {
  load_balancer_arn = aws_lb.my-load-balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-target-group.arn
  }
}

resource "aws_autoscaling_group" "my-asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = data.aws_subnets.default.ids
  launch_template {
    id      = aws_launch_template.my-launch-template.id
    version = "$Latest"
  }
  target_group_arns    = [aws_lb_target_group.my-target-group.arn]

}





