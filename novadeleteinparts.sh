#!/bin/bash
source /root/stackrc

nova list | grep ACTIVE > novalisttemp.txt
TOTAL=$(cat novalisttemp.txt | wc -l)
OLD=$TOTAL
while [ $TOTAL -gt 0 ]
do
    echo "*********************** Number of VMs: $TOTAL *************"
    echo "*********************** OLD of VMs: $OLD  ***************"
    if [ $TOTAL -eq $OLD ]
    then
       for VMNAME in $(tail -n 20 novalisttemp.txt | awk '{ print $2 }')
       do
          echo deleting vm $VMNAME
          nova delete $VMNAME  
       done
       OLD=$(($OLD-20))
       if [ $OLD -lt 0 ]
       then 
           OLD=0
       fi
    else
       sleep 5
    fi
    nova list | grep ACTIVE > novalisttemp.txt
    TOTAL=$(cat novalisttemp.txt | wc -l)
done
rm novalisttemp.txt

