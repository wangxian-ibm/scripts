#!/bin/bash
source /root/stackrc


LIST=$(nova list | grep 192 | cut -d'|' -f7 | cut -d'=' -f2 )
for IP in $LIST
    do
	ping -c 3 $IP
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

