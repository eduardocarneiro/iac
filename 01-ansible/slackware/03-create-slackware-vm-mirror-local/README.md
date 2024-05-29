## How to use the ansible playbook-createvm-slackware-vm-mirror-local.yaml

First we need to install the some packages
```
root@ansible:~/gitlab-local/01-ansible/03-create-slackware-vm-mirror-local# ansible-galaxy collection install vmware.vmware_rest

root@ansible:~/gitlab-local/01-ansible/03-create-slackware-vm-mirror-local# pip3 install aiohttp

root@ansible:~/gitlab-local/01-ansible/03-create-slackware-vm-mirror-local# ansible-galaxy collection install ansible.posix
```

### How to use the playbook

```
root@ansible:~/gitlab-local/01-ansible/03-create-slackware-vm-mirror-local# ansible-playbook -i hosts playbook-createvm-slackware-vm-mirror-local.yaml -e "ext_resource_pool='lab_local' ext_vc_folder='/LAB/vm/lab-local' ext_vm_network1='LAN' ext_vm_name='mirror.lab.local' ext_vm_ip1='192.168.0.21' ext_vm_gw='192.168.0.2' ext_vm_dns1='192.168.0.11' ext_vm_dns_search='lab.local' ext_vc_datastore='ssd_local03'"
```

Example:
```
$ ansible-playbook -i hosts playbook-createvm-slackware-vm-mirror-local.yaml -e "ext_resource_pool='ocp4.example.com' ext_vc_folder='/LAB/vm/redhat/openshift/ocp4-example' ext_vm_network1='OCP4-EXAMPLE' ext_vm_name='testvm-mirror' ext_vm_ip1='192.168.31.86' ext_vm_gw='192.168.31.254' ext_vm_dns1='192.168.31.11' ext_vm_dns_search='example.com' ext_vc_datastore='ssd_local03'"
```






# packages to install rsync
root@testvm-mirror:~# upgradepkg --install-new /mnt/cdrom/slackware64/n/rsync-3.2.3-x86_64-4.txz
root@testvm-mirror:~# upgradepkg --install-new /mnt/cdrom/slackware64/l/lz4-1.9.3-x86_64-3.txz
root@testvm-mirror:~# upgradepkg --install-new /mnt/cdrom/slackware64/l/xxHash-0.8.1-x86_64-2.txz


# packages to install httpd/apache
commands:
root@darkstar:~# find /mnt/cdrom -iname *httpd*
root@darkstar:~# upgradepkg --install-new /mnt/cdrom/slackware64/n/httpd-2.4.52-x86_64-1.txz

root@darkstar:~# chmod +x /etc/rc.d/rc.httpd 

root@darkstar:~# /etc/rc.d/rc.httpd start
/usr/sbin/httpd: error while loading shared libraries: libaprutil-1.so.0: cannot open shared object file: No such file or directory

root@darkstar:~# upgradepkg --install-new /mnt/cdrom/slackware64/l/apr-util-1.6.1-x86_64-10.txz

root@darkstar:~# /etc/rc.d/rc.httpd start
/usr/sbin/httpd: error while loading shared libraries: libsqlite3.so.0: cannot open shared object file: No such file or directory

root@darkstar:~# upgradepkg --install-new /mnt/cdrom/slackware64/ap/sqlite-3.37.2-x86_64-1.txz

root@darkstar:~# /etc/rc.d/rc.httpd start
/usr/sbin/httpd: error while loading shared libraries: libmariadb.so.3: cannot open shared object file: No such file or directory

root@darkstar:~# upgradepkg --install-new /mnt/cdrom/slackware64/ap/mariadb-10.5.13-x86_64-2.txz

root@darkstar:~# /etc/rc.d/rc.httpd start
/usr/sbin/httpd: error while loading shared libraries: libapr-1.so.0: cannot open shared object file: No such file or directory

root@darkstar:~# upgradepkg --install-new /mnt/cdrom/slackware64/l/apr-1.7.0-x86_64-3.txz

root@darkstar:~# /etc/rc.d/rc.httpd start
/usr/sbin/httpd: error while loading shared libraries: libicui18n.so.69: cannot open shared object file: No such file or directory

root@darkstar:~# upgradepkg --install-new /mnt/cdrom/slackware64/l/icu4c-69.1-x86_64-1.txz


references:
    Adds a virtual CD-ROM device to the virtual machine.
    https://docs.ansible.com/ansible/latest/collections/vmware/vmware_rest/vcenter_vm_hardware_cdrom_module.html --- IMPORTANT (also get info from VM)
    https://docs.ansible.com/ansible/2.9/modules/vmware_guest_module.html#vmware-guest-module
    https://github.com/ansible-collections/community.vmware/issues/373

    Govc connect cd-rom
        root@ansible:~/gitlab-local/01-ansible/03-create-slackware-vm-mirror-local# govc device.cdrom.insert -vm testvm-mirror -device cdrom-3000 -ds=/LAB/datastore/ssd_local04  iso/linux/slackware/slackware64-15.0-install-dvd.iso
        root@ansible:~/gitlab-local/01-ansible/03-create-slackware-vm-mirror-local# govc device.connect -vm testvm-mirror cdrom-3000 
        root@ansible:~/gitlab-local/01-ansible/03-create-slackware-vm-mirror-local# govc vm.power -on testvm-mirror
        Powering on VirtualMachine:vm-16734... OK

        https://github.com/vmware/govmomi/issues/1713
    
    httpd/apache
        Setup Apache httpd server
        https://docs.slackware.com/howtos:network_services:setup_apache

    fdisk
        command:
            printf 'o\nn\np\n1\n\n\nw' | fdisk /dev/sda
            https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script

    ansible:
        synchronize:
        https://docs.ansible.com/ansible/latest/collections/ansible/posix/synchronize_module.html