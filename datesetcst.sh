#!/bin/bash
update_kernel_params() {
        echo Setting date on  $1
        ssh $1 bash -c "'
cp /usr/share/zoneinfo/America/Chicago /etc/localtime
date
        '"
}

for i in `seq 1 50`;
do
    update_kernel_params compute$i
done

update_kernel_params controller1
update_kernel_params controller2

