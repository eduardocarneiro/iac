## to use the playbook-createvm-gw-fw-router.yaml 

Option 1: Global FW/GW
```
$ ssh root@192.168.0.13

root@ansible:~# cd gitlab-local

root@ansible:~/gitlab-local# git clone http://gitlab.lab.local/study/devops/09-iac/01-ansible.git

root@ansible:~/gitlab-local# cd 01-ansible/02-create-slackware-vm-fw-gw/

root@ansible:~/gitlab-local/01-ansible/02-create-slackware-vm-fw-gw# ansible-playbook -i hosts playbook-createvm-gw-fw-router.yaml -e "ext_global_fw_gw='true' ext_resource_pool='lab_local' ext_vc_folder='/LAB/vm/lab-local' ext_vm_network1='LAN' ext_vm_network2='GW' ext_vm_name='gw.lab.local' ext_vm_ip1='192.168.0.2' ext_vm_ip2='7.7.7.254' ext_vm_gw='192.168.0.3' ext_vm_dns1='192.168.0.11' ext_vm_dns_search='lab.local'"

NOTE: ```sample: playbook to test it```
```
$ ansible-playbook -i hosts playbook-createvm-gw-fw-router.yaml -e "ext_global_fw_gw='true' ext_resource_pool='ocp4.example.com' ext_vc_folder='/LAB/vm/redhat/openshift/ocp4-example' ext_vm_network1='GW' ext_vm_network2='LAN' ext_vm_name='gw.lab.local' ext_vm_ip1='7.7.7.254' ext_vm_ip2='192.168.31.97' ext_vm_gw='7.7.7.254' ext_vm_dns1='192.168.31.11' ext_vm_dns_search='example.com'"
```

Option 4: Local FW/GW
```
$ ssh root@192.168.0.13

root@ansible:~# cd gitlab-local

root@ansible:~/gitlab-local# git clone http://gitlab.lab.local/study/devops/09-iac/01-ansible.git

root@ansible:~/gitlab-local# cd 01-ansible/02-create-slackware-vm-fw-gw/

root@ansible:~/gitlab-local/01-ansible/02-create-slackware-vm-fw-gw# time ansible-playbook -i hosts playbook-createvm-gw-fw-router.yaml -e "ext_global_fw_gw='false' ext_resource_pool='ocp4.example.com' ext_vc_folder='/LAB/vm/redhat/openshift/ocp4-example' ext_vm_network_range='192.168.31.0' ext_vm_network1='GW' ext_vm_network2='OCP4-EXAMPLE' ext_vm_name='gw.example.com' ext_vm_ip1='7.7.7.11' ext_vm_ip2='192.168.31.254' ext_vm_gw='7.7.7.254' ext_vm_dns1='192.168.31.11' ext_vm_dns_search='example.com'"
```
NOTE: ```sample: playbook to test it```
```
root@ansible:~/gitlab-local/01-ansible/02-create-slackware-vm-fw-gw# time ansible-playbook -i hosts playbook-createvm-gw-fw-router.yaml -e "ext_global_fw_gw='false' ext_resource_pool='ocp4.example.com' ext_vc_folder='/LAB/vm/redhat/openshift/ocp4-example' ext_vm_network1='GW' ext_vm_network2='OCP4-EXAMPLE' ext_vm_name='testvm-1nic' ext_vm_ip1='7.7.7.25' ext_vm_ip2='192.168.31.97' ext_vm_gw='7.7.7.254' ext_vm_dns1='192.168.31.11' ext_vm_dns_search='example.com'"
```

## references

* Ansible.Builtin
https://docs.ansible.com/ansible/latest/collections/ansible/builtin/index.html

* Anisble for VMware
https://docs.ansible.com/ansible/latest/collections/community/vmware/index.html

* Template Designer Documentation
https://jinja.palletsprojects.com/en/3.1.x/templates/

 * How to create dynamic inventory files in Ansible
https://www.redhat.com/sysadmin/ansible-dynamic-inventories
https://stackoverflow.com/questions/33222641/override-hosts-variable-of-ansible-playbook-from-the-command-line