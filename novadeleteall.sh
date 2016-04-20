#!/bin/bash
source /root/stackrc

IDS=$(nova list   | awk '{ print $2 }')
for X in $IDS
    do
      echo deleting vm $X  
      nova delete $X
      sleep 1
    done




