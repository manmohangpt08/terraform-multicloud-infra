resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
  identifier           = "${var.name}-db"
  engine               = var.engine
  instance_class       = var.instance_class
  name                 = var.name
  username             = var.username
  password             = var.password
  allocated_storage    = var.allocated_storage
  multi_az             = var.multi_az
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.this.name
}
