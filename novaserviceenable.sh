#!/bin/bash
source /root/stackrc

for i in `seq 32 100`;
do
    nova service-enable 100-node-compute$i nova-compute   
done
