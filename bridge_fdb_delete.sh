#!/bin/bash
update_kernel_params() {
        echo "*************** Deleting bridge fdb 00:00:00:00 for $1 ********************************"
        echo "***************************************************************************************"
        ssh $1 bash -c "'
bridge fdb del 00:00:00:00:00:00 dev vxlan-2
        '"
}

for i in `seq 1 70`;
do
    update_kernel_params compute$i
done
