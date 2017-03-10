### Variables
variable db_storage {
  default = "5"
}

variable db_engine {
  default = "mysql"
}

variable db_instance_type {
  default = "db.t1.micro"
}

variable db_user {
  default = "admin"
}

variable db_password {
  default = "devops2017"
}

# The name of the database is already in the snapshot
variable db_snapshot {
  default = "arn:aws:rds:eu-west-1:446240913558:snapshot:devops-crashcourse"
}

### Resources
resource "aws_db_subnet_group" "mysql" {
  name       = "${var.project_name}-mysql-subnet"
  subnet_ids = ["${aws_subnet.public.*.id}"]
}

resource "aws_db_instance" "mysql" {
  allocated_storage      = "${var.db_storage}"
  engine                 = "${var.db_engine}"
  instance_class         = "${var.db_instance_type}"
  username               = "${var.db_user}"
  password               = "${var.db_password}"
  db_subnet_group_name   = "${aws_db_subnet_group.mysql.id}"
  vpc_security_group_ids = ["${aws_security_group.mysql.id}"]
  snapshot_identifier    = "${var.db_snapshot}"
}

### Outputs
output "mysql_host" {
  value = "${aws_db_instance.mysql.address}"
}

output "mysql_db" {
  value = "${aws_db_instance.mysql.name}"
}

output "mysql_user" {
  value = "${aws_db_instance.mysql.username}"
}

output "mysql_password" {
  value = "${var.db_password}"
}
