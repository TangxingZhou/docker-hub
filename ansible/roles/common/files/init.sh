#!/usr/bin/env bash

set -x

eth=`nmcli connection show | grep -m 1 bridge | awk '{print $1}'`
sed -i 's/\(ONBOOT=\)\w\+/\1yes/' /etc/sysconfig/network-scripts/ifcfg-$eth
systemctl restart network

sed -i 's/^PasswordAuthentication\s\+no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i '/PermitRootLogin\s\+yes/s/^#//' /etc/ssh/sshd_config
systemctl restart sshd
