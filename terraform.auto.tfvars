region     = "us-east-1"
vpc_id               = "vpc-04523bdfdb8a58a65"
cidr_block           = "10.0.0.0/16"
az              = ["us-east-1a", "us-east-1b"]
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = [ "10.0.3.0/24", "10.0.4.0/24"]
eks_version = 1.22
env = "non-prod"
