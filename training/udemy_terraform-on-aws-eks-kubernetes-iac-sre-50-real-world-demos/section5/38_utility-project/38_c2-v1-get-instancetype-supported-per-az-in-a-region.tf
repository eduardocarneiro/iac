# Datasource
// ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_instance_type_offerings

data "aws_ec2_instance_type_offerings" "my_instance_type1" {
  filter {
    name   = "instance-type"
    values = [ "t2.small" ]
  }

  filter {
    name   = "location"
    #values = ["sa-east-1a"]
    values = ["sa-east-1b"]
    #values = [ "sa-east-1c"]
  }

  location_type = "availability-zone"
}

# Output

output "output_v1_1" {
    value = data.aws_ec2_instance_type_offerings.my_instance_type1.instance_types
}
