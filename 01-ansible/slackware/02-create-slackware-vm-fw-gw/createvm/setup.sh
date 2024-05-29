#!/bin/bash

clear
read -p "What is the Resource Pool: " resourcePool

read -p "What is the vCenter Folder: " tempVcenterFolder
vcenterFolder=$(govc folder.info $tempVcenterFolder | grep Path | awk '{ print $2}')

read -p "What is the vCenter Network: " vcenterNetwork

read -p "What is the VM name: " vmName

read -p "What is the VM IP: " vmIP

read -p "What is the VM GW: " vmGW

read -p "What is the VM DNS1: " vmDNS1

read -p "What is the VM dns_search: " vmDnsSearch

ansible-playbook -i hosts createvm.yaml -e "ext_resource_pool='${resourcePool}' ext_vc_folder='${vcenterFolder}' ext_vm_network='${vcenterNetwork}' ext_vm_name='${vmName}' ext_vm_ip='${vmIP}' ext_vm_gw='${vmGW}' ext_vm_dns1='${vmDNS1}' ext_vm_dns_search='${vmDnsSearch}'"
