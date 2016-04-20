#!/bin/bash
update_kernel_params() {
        echo modify neutron agent on $1
        scp linuxbridge_neutron_agent.py.workingfix  $1:/opt/bbc/openstack-11.0-bbc170/neutron/lib/python2.7/site-packages/neutron/plugins/linuxbridge/agent/linuxbridge_neutron_agent.py
}

for i in `seq 1 100`;
do
    update_kernel_params compute$i
done
update_kernel_params controller1
update_kernel_params controller2
