# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances
module "private_sg" {
  # depends_on = [ module.loadbalancer_sg ]
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"
  
  name = "private-sg"
  description = "Security Group with HTTP & SSH port open for entire VPC Block (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  #ingress_rules = ["ssh-tcp", "http-80-tcp", "http-8080-tcp"]
  #ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.loadbalancer_sg.security_group_id
    },
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.loadbalancer_sg.security_group_id
    },
    {
      rule                     = "http-8080-tcp"
      source_security_group_id = module.loadbalancer_sg.security_group_id
    },
  ]
  number_of_computed_ingress_with_source_security_group_id = 3
  
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}

