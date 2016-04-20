#!/bin/bash
update_kernel_params() {
        echo "*************** Showing bridge fdb 00:00:00:00 for $1 ********************************"
        echo "***************************************************************************************"
        ssh $1 bash -c "'
bridge fdb show | grep 00:00:00:00:00
        '"
}

for i in `seq 1 70`;
do
    update_kernel_params compute$i
done
