#!/bin/bash
update_kernel_params() {
        echo Adding FDB params  $1
        ssh $1 bash -c "'bridge fdb append 00:00:00:00:00:00 dev vxlan-2 dst 10.130.101.139 self permanent
                         bridge fdb append 00:00:00:00:00:00 dev vxlan-2 dst 10.130.101.138 self permanent
'"
}

for i in `seq 1 100`;
do
    update_kernel_params compute$i
done


