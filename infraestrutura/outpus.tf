output "vpc_name" {
  value = module.lab_vpc.name
}

output "vpc_id" {
  value = module.lab_vpc.vpc_id
}

output "vpc_cidr" {
  value = module.lab_vpc.vpc_cidr_block
}

output "public_subnets_ids" {
  value = module.lab_vpc.public_subnets
}

output "private_subnets_ids" {
  value = module.lab_vpc.private_subnets
}

output "private_subnets_cidrs" {
  value = module.lab_vpc.private_subnets_cidr_blocks
}

output "public_subnets_cidrs" {
  value = module.lab_vpc.public_subnets_cidr_blocks
}
