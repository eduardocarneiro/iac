# Datasource
// ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_instance_type_offerings

data "aws_ec2_instance_type_offerings" "my_instance_type2" {
  for_each = toset([ "sa-east-1a", "sa-east-1b", "sa-east-1c" ])
  filter {
    name   = "instance-type"
    values = [ "t2.small" ]
  }

  filter {
    name   = "location"
    values = [each.key]

  }

  location_type = "availability-zone"
}

# Output
output "output_v2_1" {
    #value = data.aws_ec2_instance_type_offerings.my_instance_type1.instance_types
    value = toset([ for t in data.aws_ec2_instance_type_offerings.my_instance_type2: t.instance_types])
}

# Output-2
output "output_v2_2" {
    //value = data.aws_ec2_instance_type_offerings.my_instance_type1.instance_types
    //value = toset([ for t in data.aws_ec2_instance_type_offerings.my_instance_type2: t.instance_types])
    value = {
        for az, details in data.aws_ec2_instance_type_offerings.my_instance_type2: az => details.instance_types

    }
}
