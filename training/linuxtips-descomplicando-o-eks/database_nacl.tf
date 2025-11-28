resource "aws_network_acl" "database" {
  vpc_id = aws_vpc.main.id

  egress {
    rule_no    = 200
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = format("%s-database", var.nacl_name)
  }
}

resource "aws_network_acl_rule" "deny" {
  network_acl_id = aws_network_acl.database.id
  rule_action    = "deny"
  rule_number    = "300"

  protocol   = "-1"
  cidr_block = "0.0.0.0/0"
  from_port  = 0
  to_port    = 0

}


