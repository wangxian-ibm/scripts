#!/bin/bash
source /root/stackrc

ADMINUSER=$(keystone user-list | grep " admin " | awk '{ print $2 }')
ADMINTENANT=$(keystone tenant-list | grep " admin " | awk '{ print $2 }')
echo "admin user:   $ADMINUSER"
echo "admin tenant: $ADMINTENANT"

echo "******************** Showing quotas before ********************"
nova quota-show --user $ADMINUSER --tenant $ADMINTENANT 
neutron quota-show --tenant-id $ADMINTENANT 

echo "******************** changing quotas ********************"
#: <<'END'
nova quota-update --instances -1 --user $ADMINUSER $ADMINTENANT 
nova quota-update --ram -1 --user $ADMINUSER $ADMINTENANT
nova quota-update --fixed-ips -1 --user $ADMINUSER $ADMINTENANT
nova quota-update --cores -1 --user $ADMINUSER $ADMINTENANT
neutron quota-update --port -1
#END

echo "******************** Showing quotas after ********************"
nova quota-show --user $ADMINUSER --tenant $ADMINTENANT
neutron quota-show --tenant-id $ADMINTENANT

