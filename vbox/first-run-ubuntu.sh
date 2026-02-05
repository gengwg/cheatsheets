#!/usr/bin/env bash
# To aid cloning a base installed Ubuntu 12 virtual machine in VirtualBox
# Usage: sudo ./first-run-ubuntu.sh

echo "Generating new host keys (enter a passphrase)..."
sleep 2
rm -f /etc/ssh/ssh_host_rsa_key*
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
echo "Set a hostname..."
sleep 2
vi /etc/hostname
vi /etc/hosts
echo "Update MAC address and/or the device name (to eth0)..."
sleep 2
# delete eth0 line. change eth1 line to eth0.
# or simply remove it?
# seems no need for ubuntu 14.04 desktop?
vi /etc/udev/rules.d/70-persistent-net.rules
echo "You should reboot now."

