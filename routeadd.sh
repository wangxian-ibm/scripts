#!/bin/bash
update_kernel_params() {
        echo adding route $1
        ssh $1 bash -c "' 
ip route del 10.130.101.128/26
ip route add 10.130.101.128/26 via 10.130.202.129 dev bond0
        '"
}

for i in `seq 51  70`;
do
    update_kernel_params compute$i
done
