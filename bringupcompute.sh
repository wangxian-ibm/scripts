#!/bin/bash
update_kernel_params() {
        echo enable nova  $1
        ssh $1 bash -c "'source stackrc
nova service-enable 100-node-$1 nova-compute
'"
}

for i in `seq 90 100`;
do
    update_kernel_params compute$i
done


