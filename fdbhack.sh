#!/bin/bash


PRIVATE_IPS=$(cat private_ip_list.txt)
for IP in $PRIVATE_IPS
do
                              echo adding $IP
                               bridge fdb append 00:00:00:00:00:00 dev vxlan-2 dst $IP self permanent
                               
done



