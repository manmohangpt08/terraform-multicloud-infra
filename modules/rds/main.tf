module "rds" {
  source             = "../../modules/rds"
  name               = "${var.env}-db"
  engine             = "postgres"
  username           = "admin"
  password           = "ChangeMe123!"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  multi_az           = false
  subnet_ids         = module.vpc.private_subnet_ids

  depends_on = [module.vpc]
}
