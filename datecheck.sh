#!/bin/bash
update_kernel_params() {
        echo Checking date on  $1
        ssh $1 bash -c "'
date
        '"
}

for i in `seq 1 50`;
do
    update_kernel_params compute$i
done

update_kernel_params controller1
update_kernel_params controller2

