#!/bin/bash
update_kernel_params() {
        echo Checking brq interface on  $1
        ssh $1 bash -c "'
ip a | grep brq
        '"
}

for i in `seq 1 100`;
do
    update_kernel_params compute$i
done
#update_kernel_params controller1
#update_kernel_params controller2
