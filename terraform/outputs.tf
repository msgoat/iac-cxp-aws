output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets.*.id
}

output "loadbalancer_arn" {
  value = aws_lb.loadbalancer.arn
}

output "loadbalancer_dns_name" {
  value = aws_lb.loadbalancer.dns_name
}

output "loadbalancer_security_group_id" {
  value = aws_security_group.loadbalancer.id
}

output "ingress_security_group_id" {
  value = aws_security_group.ingress.id
}