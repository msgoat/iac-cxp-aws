# loadbalancer_rules.tf
# --------------------------------------------------------------------
# adds all forwarding rules to loadbalancer
# --------------------------------------------------------------------
#

locals {
  lb_route_names = [
    "iam",
    "apps"]
  oidc_authorization_endpoint = "https://iam.cxp.k8s.aws.msgoat.eu/auth/realms/CXP/protocol/openid-connect/auth"
  oidc_issuer = "https://iam.cxp.k8s.aws.msgoat.eu/auth/realms/CXP"
  oidc_token_endpoint = "https://iam.cxp.k8s.aws.msgoat.eu/auth/realms/CXP/protocol/openid-connect/token"
  oidc_user_info_endpoint = "https://iam.cxp.k8s.aws.msgoat.eu/auth/realms/CXP/protocol/openid-connect/userinfo"
}

resource "aws_lb_listener_rule" "routes" {
  count = length(local.lb_route_names)
  listener_arn = aws_lb_listener.https.arn

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ingress.arn
  }

  condition {
    host_header {
      values = [
        "${local.lb_route_names[count.index]}.${var.cluster_domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "kibana" {
  listener_arn = aws_lb_listener.https.arn

  action {
    type = "authenticate-oidc"

    authenticate_oidc {
      authorization_endpoint = local.oidc_authorization_endpoint
      client_id = "eks-cxp-kibana"
      client_secret = "28859cda-9122-4c6f-88cb-4921f5427477"
      issuer = local.oidc_issuer
      token_endpoint = local.oidc_token_endpoint
      user_info_endpoint = local.oidc_user_info_endpoint
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ingress.arn
  }

  condition {
    host_header {
      values = [
        "kibana.${var.cluster_domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "traefik" {
  listener_arn = aws_lb_listener.https.arn

  action {
    type = "authenticate-oidc"

    authenticate_oidc {
      authorization_endpoint = local.oidc_authorization_endpoint
      client_id = "eks-cxp-traefik"
      client_secret = "152866a6-6a83-4d39-909f-403df9822c21"
      issuer = local.oidc_issuer
      token_endpoint = local.oidc_token_endpoint
      user_info_endpoint = local.oidc_user_info_endpoint
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ingress.arn
  }

  condition {
    host_header {
      values = [
        "traefik.${var.cluster_domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "grafana" {
  listener_arn = aws_lb_listener.https.arn

  action {
    type = "authenticate-oidc"

    authenticate_oidc {
      authorization_endpoint = local.oidc_authorization_endpoint
      client_id = "eks-cxp-grafana"
      client_secret = "810790b6-44f9-4237-8608-d554ebc2d8eb"
      issuer = local.oidc_issuer
      token_endpoint = local.oidc_token_endpoint
      user_info_endpoint = local.oidc_user_info_endpoint
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ingress.arn
  }

  condition {
    host_header {
      values = [
        "grafana.${var.cluster_domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "jaeger" {
  listener_arn = aws_lb_listener.https.arn

  action {
    type = "authenticate-oidc"

    authenticate_oidc {
      authorization_endpoint = local.oidc_authorization_endpoint
      client_id = "eks-cxp-jaeger"
      client_secret = "8df99b4e-b7ed-4f72-9725-0d39b2af033c"
      issuer = local.oidc_issuer
      token_endpoint = local.oidc_token_endpoint
      user_info_endpoint = local.oidc_user_info_endpoint
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ingress.arn
  }

  condition {
    host_header {
      values = [
        "jaeger.${var.cluster_domain_name}"]
    }
  }
}
