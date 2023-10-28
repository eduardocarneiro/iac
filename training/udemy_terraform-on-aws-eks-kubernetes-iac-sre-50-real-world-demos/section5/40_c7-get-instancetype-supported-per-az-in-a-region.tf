# Get list of AZs in a specific region
# Region is set in 38-c1-version.tf in provider block
# Datasource-1
data "aws_availability_zones" "my_azs" {
    filter {
      name = "opt-in-status"
      values = [ "opt-in-not-required" ]
    }
  
}

# Datasource-2
// ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_instance_type_offerings

data "aws_ec2_instance_type_offerings" "my_instance_type" {
  #for_each = toset([ "sa-east-1a", "sa-east-1b", "sa-east-1c" ])
  for_each = toset(data.aws_availability_zones.my_azs.names)
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

# Output-1
# Basic output: All Azs mapped to supported instance type
output "output_v3_1" {
    value = {
        for az, details in data.aws_ec2_instance_type_offerings.my_instance_type: az => details.instance_types
    }
}

# Output-2
# Filtered output: exclude unsupported AZs
# 
output "output_v3_2" {
    value = {
        for az, details in data.aws_ec2_instance_type_offerings.my_instance_type: az => details.instance_types if length(details.instance_types) != 0
    }
}

# Output-3
# Filtered output: with keys function - which gets keys from a map
# this will return the list of AZs supported for a instance type
# 
output "output_v3_3" {
    value = keys({
        for az, details in data.aws_ec2_instance_type_offerings.my_instance_type: az => details.instance_types if length(details.instance_types) != 0
    })
}

# Output-4
# Filtered output: the output is a list, lets get the first item from list
output "output_v3_4" {
    value = keys({
        for az, details in data.aws_ec2_instance_type_offerings.my_instance_type: az => details.instance_types if length(details.instance_types) != 0
    })[0]
}
