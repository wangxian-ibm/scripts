#!/bin/bash
update_kernel_params() {
        echo "****************************testing ssh for $1*************************************"
        echo "***********************************************************************************"
        ssh $1 bash -c "'
ping -c 3 www.google.com
ping -c 3 10.130.101.138
sudo -u nova -H /bin/sh -c /var/lib/nova/bin/verify-ssh
        '"
}

for i in `seq 40 40`;
do
    update_kernel_params compute$i
done
