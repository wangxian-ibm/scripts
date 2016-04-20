#!/bin/bash
update_kernel_params() {
        echo Update timeout  $1
        cat neutronaddtimeout.sh | ssh $1 
            
}

for i in `seq 1 100`;
do
    update_kernel_params compute$i
done
update_kernel_params controller1
update_kernel_params controller2
