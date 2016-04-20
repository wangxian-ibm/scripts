#!/bin/bash
update_kernel_params() {
        echo Checking ARP on  $1
        ssh $1 bash -c "'
lsblk | grep \"sda \"        
        '"
}

for i in `seq 1 100`;
do
    update_kernel_params compute$i
done
#update_kernel_params controller1
#update_kernel_params controller2
