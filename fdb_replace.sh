#!/bin/bash
update_kernel_params() {
   ssh $1 bash -c "'
   arp -an | grep 123.$2.1.1
   arp -an | grep 123.$2.2.1 
'"
}


echo $1
update_kernel_params compute$1 $1



