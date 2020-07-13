# variables.tf
# ---------------------------------------------------------------------------
# Defines all input variable for this demo.
# ---------------------------------------------------------------------------

variable "region_name" {
  description = "The AWS region to deploy into (e.g. eu-central-1)."
}

variable "organization_name" {
  description = "The name of the organization that owns all AWS resources."
}

variable "department_name" {
  description = "The name of the department that owns all AWS resources."
}

variable "project_name" {
  description = "The name of the project that owns all AWS resources."
}

variable "stage" {
  description = "The name of the current environment stage."
}

variable "network_cidr" {
  description = "The CIDR range of the VPC."
}

variable "inbound_traffic_cidrs" {
  description = "The IP ranges in CIDR notation allowed to access any public ressource within the network."
  type = list(string)
}

variable "cluster_name" {
  description = "Logical name of the Kubernetes cluster"
}

variable "cluster_domain_name" {
  description = "Domain name used to route traffic to the cluster"
}

variable "tf_remote_state_name" {
  description = "Name of a S3 bucket and a Dynamo DB to store Terraforms remote state"
  default = ""
}
