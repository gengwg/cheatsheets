#!/usr/bin/env bash
# To aid cloning a base installed CentOS 6 virtual machine in VirtualBox
echo "Generating new host keys (enter a passphrase)..."
sleep 3
rm -f /etc/ssh/ssh_host_rsa_key*
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

echo "Set a hostname..."
sleep 3
vi /etc/sysconfig/network
sleep3 
vi /etc/hosts

echo "Update MAC address and/or the device name (to eth0)..."
echo "Usually just delete the first device and set next device to eth0."
sleep 3
vi /etc/udev/rules.d/70-persistent-net.rules

echo "Update MAC address and IP (if using static IP)..."
sleep 3
vi /etc/sysconfig/network-scripts/ifcfg-eth0
echo "You should reboot now."

