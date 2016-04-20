#!/bin/bash
source /root/stackrc
IMAGE_ID=$(nova image-list | grep "nw_snapshot" | cut -d"|" -f2 | tr -d '[[:space:]]')

for i in `seq 1 1`;
do
    nova boot --image $IMAGE_ID --nic net-id=68610b29-910f-4ac6-a925-cd312e26a4e8 --flavor m1.small  --availability-zone nova:100-node-compute$i --security-groups 98a683c2-c720-4360-a816-bbe66913fa44 vmtest$i

    sleep 2
done
