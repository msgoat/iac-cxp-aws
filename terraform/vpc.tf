# vpc.tf
# Creates a new VPC in the specified region spanning all active availability
# zones.

# --- VPC --------------------------------------------------------------------

# Create a VPC to launch our instances into
resource "aws_vpc" "vpc" {
  cidr_block = var.network_cidr
  # all public available instances should have DNS names
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = merge(
  map( "Name", "vpc-${var.region_name}-${lower(var.cluster_name)}",
  "kubernetes.io/cluster/${local.eks_cluster_name}", "shared"),
  local.common_tags)
}

# --- Internet Gateway -------------------------------------------------------

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(map("Name", "igw-${var.region_name}-${lower(var.cluster_name)}"), local.common_tags)
}

