#!/bin/bash
update_kernel_params() {
        echo Cleaning up 00:00:00:00:00:00 entries in fdb table on  $1
        ssh $1 bash -c "'
        bridge fdb delete 00:00:00:00:00:00 dev vxlan-42
        '"
}
#update_kernel_params controller1
#update_kernel_params controller2

for i in `seq 2 3`;
do
    update_kernel_params compute$i
done


