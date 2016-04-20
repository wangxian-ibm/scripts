#!/bin/bash
update_kernel_params() {
        echo Update timeout  $1
        cat fixvxlangroup.sh | ssh $1 
            
}

for i in `seq 2 100`;
do
    update_kernel_params compute$i
done
