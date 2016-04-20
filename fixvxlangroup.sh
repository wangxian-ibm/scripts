#!/bin/bash
sed -i "s/vxlan_group = 239.1.1.1/#vxlan_group = 239.1.1.1/g" /etc/neutron/plugins/ml2/ml2_plugin.ini
service neutron-linuxbridge-agent stop
service neutron-linuxbridge-agent start
