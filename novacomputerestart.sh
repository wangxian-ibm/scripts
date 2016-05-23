#!/bin/bash
update_kernel_params() {
        echo Restart nova-compute on $1
        ssh $1 bash -c "'
        . stackrc
        service nova-compute restart
        '"
}

for i in `seq 1 2`;
do
    update_kernel_params compute$i
done
