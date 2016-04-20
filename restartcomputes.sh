#!/bin/bash
update_kernel_params() {
        echo reboot  $1
        ssh $1 bash -c "'reboot'"
}

for i in `seq 2 100`;
do
    update_kernel_params compute$i
done


