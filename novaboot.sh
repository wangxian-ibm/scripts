#!/bin/bash
source /root/stackrc

for i in `seq 1 1`;
do
    nova boot --image c136d591-0979-4411-a5fa-77d9a49a987f --nic net-id=e04f130c-607c-4902-89a4-bf1796ca7bcf --user-data data.txt --flavor m1.small  --availability-zone nova:100-node-compute$i --security-groups 98a683c2-c720-4360-a816-bbe66913fa44 vmtest$i

    sleep 2
done
