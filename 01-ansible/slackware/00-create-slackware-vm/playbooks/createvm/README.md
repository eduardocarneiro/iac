
# how to use this playbook

This is an example to perform the ansible
```
$ ansible-playbook -i hosts createvm.yaml -e "ext_resource_pool='ocp4.example.com' ext_vc_folder='/LAB/vm/redhat/openshift/ocp4-example' ext_vm_network='OCP4-EXAMPLE' ext_vm_name='teste01-FW' ext_vm_ip='192.168.31.93' ext_vm_gw='192.168.31.254' ext_vm_dns1='192.168.31.11' ext_vm_dns_search='example.com'"
```
