#!/bin/bash
update_kernel_params() {
        echo adding route $1
        ssh $1 bash -c "' 
echo "" > /etc/rc.local
service neutron-linuxbridge-agent restart
        '"
}

for i in `seq 1  30`;
do
    update_kernel_params compute$i
done
update_kernel_params controller1
update_kernel_params controller2
