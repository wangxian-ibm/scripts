#!/bin/bash
source /root/stackrc


LIST=$(nova list | grep 192 | cut -d'|' -f3 )
#echo $LIST
for IP in $LIST
    do
	nova reset-state  $IP
    done


#echo $LIST
#for ITEM in $LIST
#    do
      #echo $ITEM
#      VMNAME=$(echo $ITEM | awk -F'[,]' '{print $1}')
#      echo "******************** Pinging VM $VMNAME ******************************"
#      VMIP=$(echo $ITEM | awk -F'[,]' '{print $2}')
#      echo "******************** IP $VMIP   ********************************"
#      ping $VMIP -c3
#      echo ""
#    done

