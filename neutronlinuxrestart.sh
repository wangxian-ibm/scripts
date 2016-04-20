#!/bin/bash
update_kernel_params() {
        echo restart neutron linux bridge agent  $1
        ssh $1 bash -c "'service neutron-linuxbridge-agent stop
        service neutron-linuxbridge-agent start

 
        '"
}

for i in `seq 1 100`;
do
    update_kernel_params compute$i
done
update_kernel_params controller1
update_kernel_params controller2
