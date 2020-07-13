# loadbalancer.tf
#----------------------------------------------------------------------
# creates an Application Loadbalancer in front of the EKS cluster
#----------------------------------------------------------------------
#

resource aws_lb loadbalancer {
  name = "alb-${local.eks_cluster_name}"
  internal = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.loadbalancer.id]
  subnets = aws_subnet.public_subnets.*.id
  tags = merge(map("Name", "alb-${local.eks_cluster_name}"), local.common_tags)
}

# --- listeners

resource aws_lb_listener http {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource aws_lb_listener https {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate.cert.arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ingress.arn
  }
}

# --- listener rules

# --- target groups

resource aws_lb_target_group ingress {
  name = "tg-${local.eks_cluster_name}"
  port = 32080
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id

  health_check {
    path = "/ping"
    protocol = "HTTP"
    healthy_threshold = 5
    unhealthy_threshold = 3
    timeout = 5
  }

  tags = local.common_tags
}

# --- security groups

resource aws_security_group loadbalancer {
  name = "sec-alb-${local.eks_cluster_name}"
  description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.vpc.id
  tags = merge(map("Name", "sg-alb-${local.eks_cluster_name}"), local.common_tags)
}

resource "aws_security_group_rule" "allow_inbound_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = var.inbound_traffic_cidrs
  security_group_id = aws_security_group.loadbalancer.id
}

resource "aws_security_group_rule" "allow_inbound_https" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = var.inbound_traffic_cidrs
  security_group_id = aws_security_group.loadbalancer.id
}

resource "aws_security_group_rule" "allow_outbound_any" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"]
  security_group_id = aws_security_group.loadbalancer.id
}

resource aws_security_group ingress {
  name = "sec-${local.eks_cluster_name}-worker-from-lb"
  description = "Allow EKS workers to accept traffic from loadbalancer to ingress controller"
  vpc_id = aws_vpc.vpc.id
  tags = merge(map("Name", "sg-${local.eks_cluster_name}-worker-from-lb"), local.common_tags)
}

resource aws_security_group_rule allow_http_from_lb {
  type = "ingress"
  from_port = 32080
  to_port = 32080
  protocol = "tcp"
  security_group_id = aws_security_group.ingress.id
  source_security_group_id = aws_security_group.loadbalancer.id
}

