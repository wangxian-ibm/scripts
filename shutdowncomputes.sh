#!/bin/bash
update_kernel_params() {
        echo shutting of nova and booting off  $1
        ssh $1 bash -c "'source stackrc
nova service-disable 100-node-$1 nova-compute
shutdown now'"
}

for i in `seq 31 70`;
do
    update_kernel_params compute$i
done


