#!/bin/bash
sed -i "s/agent_down_time = 75/agent_down_time = 20/g" /etc/neutron/neutron.conf
#sed -i "s/vif_plugging_timeout = 600/vif_plugging_timeout = 300/g" /etc/nova/nova.conf
#sed -i "s/heartbeat_timeout_threshold = 30/heartbeat_timeout_threshold = 100/g" /etc/nova/nova.conf
#sed -i "s/heartbeat_timeout_threshold = 30/heartbeat_timeout_threshold = 100/g" /etc/neutron/neutron.conf
service neutron-dhcp-agent stop    
service neutron-lbaasv2-agent stop     
service neutron-metadata-agent stop    
service neutron-l3-agent stop    
service neutron-linuxbridge-agent stop
service neutron-server stop

service neutron-dhcp-agent start     
service neutron-lbaasv2-agent start  
service neutron-metadata-agent start  
service neutron-l3-agent start        
service neutron-linuxbridge-agent start
service neutron-server start

service nova-api stop    
service nova-cert stop     
service nova-conductor stop    
service nova-consoleauth stop    
service nova-novncproxy stop
service nova-scheduler stop
service nova-compute stop 

service nova-api start    
service nova-cert start     
service nova-conductor start    
service nova-consoleauth start    
service nova-novncproxy start
service nova-scheduler start
service nova-compute start 
