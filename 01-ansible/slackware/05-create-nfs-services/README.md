# How to use the ansible 'playbook-createvm-slackware-vm-nfs.yaml' 

## requirements:
```
slackpkg install libtirpc-1.3.2-x86_64-1
```


## play the ansible playbook
```
root@ansible:~/gitlab-local/01-ansible/05-create-nfs-services# ansible-playbook -i hosts playbook-createvm-slackware-vm-nfs.yaml -e "ext_resource_pool='ocp4.example.com' ext_vc_folder='/LAB/vm/redhat/openshift/ocp4-example' ext_vc_datastore='ssd_local03' ext_vm_network_range='192.168.31.0' ext_vm_name='testvm-nfs2' ext_vm_network1='OCP4-EXAMPLE' ext_vm_ip1='192.168.31.89' ext_vm_gw='192.168.31.254' ext_vm_dns1='192.168.31.11' ext_vm_dns_search='example.com'"

```

test it:
```
root@ansible:~/gitlab-local/01-ansible/05-create-nfs-services# ansible-playbook -i hosts playbook-createvm-slackware-vm-nfs.yaml -e "ext_resource_pool='ocp4.example.com' ext_vc_folder='/LAB/vm/redhat/openshift/ocp4-example' ext_vc_datastore='ssd_local03' ext_vm_network_range='192.168.31.0' ext_vm_name='testvm-nfs2' ext_vm_network1='OCP4-EXAMPLE' ext_vm_ip1='192.168.31.89' ext_vm_gw='192.168.31.254' ext_vm_dns1='192.168.31.11' ext_vm_dns_search='example.com'"
```


references:
    group
        ansible.builtin.group module – Add or remove groups
        https://docs.ansible.com/ansible/latest/collections/ansible/builtin/group_module.html
    user
        ansible.builtin.user module – Manage user accounts
        https://docs.ansible.com/ansible/latest/collections/ansible/builtin/user_module.html#ansible-collections-ansible-builtin-user-module

    file
        ansible.builtin.file module – Manage files and file properties
        https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html

    nfs
        exportfs -a gives 'no_subtree_check warning' when following the Installation guide
        https://issues.apache.org/jira/browse/CLOUDSTACK-586

        rpc.nfsd unable to set any sockets for nfsd
        https://vkarthickeyan.wordpress.com/2013/03/01/rpc-nfsd-unable-to-set-any-sockets-for-nfsd/

        NFS - Quick and Dirty Setup
        https://docs.slackware.com/howtos:network_services:nfs-quick_and_dirty_setup

        Home NFS Setup HOWTO
        https://docs.slackware.com/howtos:network_services:home_nfs_howto
