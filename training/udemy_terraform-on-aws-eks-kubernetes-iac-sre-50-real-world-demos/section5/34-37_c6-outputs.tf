# Terraform Output values


# EC2 Instance Public IP TOSET
output "ec2_instance_publicip" {
    description = "EC2 Instance public IP"
    //value = aws_instance.myec2vm.public_ip
    //value = toset([ for instance in aws_instance.myec2vm: instance.public_ip ])
    value = toset([ for instance in aws_instance.myec2vm: instance.public_ip ])
}

# EC2 Instance Public DNS TOSET
output "ec2_instance_publicdns" {
    description = "EC2 Instance public DNS"
    //value = aws_instance.myec2vm.public_dns
    value = toset([ for instance in aws_instance.myec2vm: instance.public_dns ])
}

# EC2 Instance Public DNS with TOMAP
output "ec2_instance_publicdns_map" {
    description = "EC2 Instance public DNS"
    //value = aws_instance.myec2vm.public_dns
    //value = tomap({ for az, instance in aws_instance.myec2vm: az => instance.public_dns })
    value = { for az, instance in aws_instance.myec2vm: az => instance.public_dns }
}

# Section 5
/* 
1. For loop with List
2. For loop with Map
3. For loop with Map Advanced
4. Legacy Splat Operator (latest) - Returns List
5. Latest Generalized Splat Operator - Returns the List
*/

/*
# Output - For Loop with List
output "for_output_list" {
    description = "For loop with list"
    value = [for instance in aws_instance.myec2vm:  instance.public_ip]
}

# Output - For Loop with Map
output "for_output_map1" {
    description = "For Loop with Map"
    value = { for instance in aws_instance.myec2vm: instance.id => instance.public_dns}  
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
    description = "For Loop with Map - Advanced"
    value = { for c, instance in aws_instance.myec2vm: c => instance.public_dns}  
}

# Output Legacy Splat Operator (Legacy) - Returns the List
output "legacy_splat_instance_publicdns" {
    description = "Legacy Slapt Operator"
    value = aws_instance.myec2vm.*.public_dns 
}

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
    description = "Legacy Slapt Operator"
    value = aws_instance.myec2vm[*].public_dns 
}
*/