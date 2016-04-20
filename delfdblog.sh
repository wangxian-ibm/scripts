#!/bin/bash
update_kernel_params() {
        echo deleting log on $1 
        ssh $1 bash -c "'
           rm /var/log/neutron/neutron-linuxbridge-agent.log 
        '"
}
update_kernel_params controller1
update_kernel_params controller2

for i in `seq 1 100`;
do
    update_kernel_params compute$i
done


