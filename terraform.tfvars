name               = "ingeniocuster"
region             = "us-east-1"
profile            = "ingenio"
Environment        = "Prod"
vpc_id             = "vpc-06cd4dcaf356d3520"
private_subnets    = ["10.0.0.0/24", "10.0.1.0/24"]
instance_type      = "db.t3.small"
vpc_rds_subnet_ids = ["subnet-08eae9626958f91b8", "subnet-0e078a9f78b8137d5"]