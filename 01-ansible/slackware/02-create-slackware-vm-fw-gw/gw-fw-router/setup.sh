#!/bin/bash

getVmFolder ()
{
    # resourcePool = ocp4.example.com
    tempVcenterFolder=$(echo $resourcePool | sed 's/\./-/g' | cut -d "-" -f1-2)
    vcenterFolder=$(govc folder.info $tempVcenterFolder | grep Path | awk '{ print $2}')
}


getvcenterNetwork ()
{
    vcenterNetwork=$(echo $resourcePool | sed 's/\./-/g' | cut -d "-" -f1-2 | tr '[:lower:]' '[:upper:]')
}


getVmNetwork ()
{
    # vmSubNetIp = 192.168.32.0
    vmIP=$(echo $vmSubNetIp | cut -d "." -f1-3).11
    vmGW=$(echo $vmSubNetIp | cut -d "." -f1-3).254
    vmDNS1=$vmIP
    vmBroadCast=$(echo $vmSubNetIp | cut -d "." -f1-3).255
}

getVmDomain ()
{
    # vmDomain = example.com
    vmDnsSearch=$vmDomain
}

#
# Main (program start)
clear
read -p "What is the Resource Pool: " resourcePool
#read -p "What is the vCenter Folder: " tempVcenterFolder
read -p "What is the VM name: " vmName
read -p "What is the Subnet IP eg.:192.168.0.0: " vmSubNetIp
read -p "What is the domain eg. example.com: " vmDomain

getVmFolder
echo $vcenterFolder

getvcenterNetwork
echo $vcenterNetwork

getVmNetwork
echo $vmIP
echo $vmGW
echo $vmDNS1
echo $vmBroadCast

getVmDomain
echo $vmDnsSearch

#
# Start ansible
#ansible-playbook -i hosts createvm.yaml -e "ext_resource_pool='${resourcePool}' ext_vc_folder='${vcenterFolder}' ext_vm_network='${vcenterNetwork}' ext_vm_name='${vmName}' ext_vm_ip='${vmIP}' ext_vm_gw='${vmGW}' ext_vm_dns1='${vmDNS1}' ext_vm_dns_search='${vmDnsSearch}'"



