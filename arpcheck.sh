#!/bin/bash
update_kernel_params() {
        echo Checking ARP on  $1
        ssh $1 bash -c "'
arp -an | grep fa:16:3e:79:74:b3 | grep PERM
        '"
}

for i in `seq 1 100`;
do
    update_kernel_params compute$i
done
#update_kernel_params controller1
#update_kernel_params controller2
