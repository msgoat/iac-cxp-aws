# dns_records.tf
# ---------------------------------------------------------------------
# adds all DNS alias records referring to the EKS cluster
# ---------------------------------------------------------------------
#

locals {
  dns_route_names = [
    "traefik",
    "iam",
    "grafana",
    "kibana",
    "jaeger",
    "apps"]
}

data aws_route53_zone target_zone {
  name = var.cluster_domain_name
}

resource "aws_route53_record" "routes" {
  count = length(local.dns_route_names)
  zone_id = data.aws_route53_zone.target_zone.zone_id
  name = "${local.dns_route_names[count.index]}.${var.cluster_domain_name}"
  type = "A"

  alias {
    name = aws_lb.loadbalancer.dns_name
    zone_id = aws_lb.loadbalancer.zone_id
    evaluate_target_health = false
  }
}