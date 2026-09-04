output "sg_id" {
    value = aws_security_group.sg.id
}
output "launch_template_id" {
    value = aws_launch_template.my-launch-template.id
}   

output "target_group_arn" {
    value = aws_lb_target_group.my-target-group.arn
}
 
