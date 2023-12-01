# How to use the ansible 'playbook-createvm-slackware-vm-dns-dhcp.yaml' 

## requirements:
```
root@ansible:~/gitlab-local/01-ansible/04-create-slackware-vm-dns-dhcp# ansible-galaxy collection install community.general
Starting galaxy collection install process
```

## play the ansible playbook
```
root@ansible:~/gitlab-local/01-ansible/04-create-slackware-vm-dns-dhcp# ansible-playbook -i hosts playbook-createvm-slackware-vm-dns-dhcp.yaml -e "ext_resource_pool='ocp4.example.com' ext_vc_folder='/LAB/vm/redhat/openshift/ocp4-example' ext_vm_name='testvm-dns-dhcp' ext_vm_network1='OCP4-EXAMPLE' ext_vm_ip1='192.168.31.87' ext_vm_gw='192.168.31.254' ext_vm_dns1='192.168.31.11' ext_vm_dns_search='example.com' ext_dhcp_subnet='192.168.31.0' ext_dhcp_range_start='192.168.31.22' ext_dhcp_range_end='192.168.31.99' ext_dhcp_broadcast_ip='192.168.31.255' ext_dns_reverse_arpa='31.168.192' ext_dns_zone_serial='2023072701'"
```