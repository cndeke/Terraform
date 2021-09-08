output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "sg_id" {
  value = aws_security_group.sg.id
}

output "pub1_subnet_id" {
  value = aws_subnet.pub1.id
}

output "pub2_subnet_id" {
  value = aws_subnet.pub2.id
}

output "pri1_subnet_id" {
  value = aws_subnet.pri1.id
}