#!/bin/bash
update_kernel_params() {
scp private_ip_list.txt $1:~/private_ip_list.txt
scp fdbhack.sh $1:~/fdbhack.sh

echo Adding FDB params  $1
ssh $1 bash -c ~/fdbhack.sh

#ssh $1 << 'EOF'
#                        for IP in $PRIVATE_IPS
#                        do
#                              echo adding $IP
#                               bridge fdb append 00:00:00:00:00:00 dev vxlan-2 dst $IP self permanent
#                        done                
#EOF







}


for i in `seq 5 5`;
do
    update_kernel_params compute$i
done


