#!/bin/bash
update_kernel_params() {
        echo size on  $1
        ssh $1  df -h | grep sda6
}

for i in `seq 1 30`;
do
    update_kernel_params compute$i
done
#update_kernel_params controller1
#update_kernel_params controller2
