# certificate.tf
#----------------------------------------------------------------
# creates a SSL certificate for HTTPS communication
#----------------------------------------------------------------
#

resource aws_acm_certificate cert {
  domain_name = var.cluster_domain_name
  subject_alternative_names = [
    "*.${var.cluster_domain_name}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = local.common_tags
}

data aws_route53_zone hosted_zone {
  name = var.cluster_domain_name
  private_zone = false
}

resource aws_route53_record cert_validation {
  name = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  records = [
    aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]
  ttl = 60
}

resource aws_acm_certificate_validation cert {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation.fqdn]
}

