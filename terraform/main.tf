# ----------------------------------------------------------------------------
# main.tf
# ----------------------------------------------------------------------------

provider "aws" {
  region = var.region_name
  version = "~> 2.7"
}

# Local values used in this module
locals {
  common_tags = {
    Organization = var.organization_name
    Department = var.department_name
    Project = var.project_name
    Stage = var.stage
  }
  eks_cluster_name = "eks-${var.region_name}-${var.cluster_name}"
}

data aws_region current {
  name = var.region_name
}

data "aws_availability_zones" "available_zones" {
  state = "available"
}

output "available_zones" {
  value = data.aws_availability_zones.available_zones.names
}
