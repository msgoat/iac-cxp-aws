# terraform.tfvars
# ---------------------------------------------------------------------------
# Provides values for all variables used in this demo which will be picked
# up automatically when running Terraform.
# ---------------------------------------------------------------------------
region_name = "eu-west-1"
organization_name = "msg systems"
department_name = "Automotive Technology"
project_name = "CXP"
stage = "dev"
network_cidr = "10.0.0.0/16"
inbound_traffic_cidrs = [
  "0.0.0.0/0"]
tf_remote_state_name = "tf-iac-at41tools"
cluster_name = "cxp"
cluster_domain_name = "cxp.k8s.aws.msgoat.eu"

