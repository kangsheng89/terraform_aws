# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances
module "db_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"
  
  name = "db-sg"
  description = "Security Group with port open from private security group, egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  
  computed_ingress_with_source_security_group_id = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from private security group"
      source_security_group_id = module.private_sg.security_group_id
    },

  ]
  number_of_computed_ingress_with_source_security_group_id = 1
  
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}

