output "private_subnet_1" {
    description = "id of private subnet 1"
    value = aws_subnet.private_1.id
}

output "private_subnet_2" {
    description = "id of private subnet 2"
    value = aws_subnet.private_2.id
}


output "security_group_ids" {
  value = aws_security_group.websg.id
}