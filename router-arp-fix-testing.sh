source /root/stackrc
PREFIX=unicorn
#PROJECT_OUTPUT=$(keystone tenant-list | grep $PREFIX )
#PROJECT_LIST=""
#for item in $PROJECT_OUTPUT;
#do
#   PROJECT_LIST="$PROJECT_LIST $(echo $item | grep $PREFIX)"
#done
#
#echo "Project List:"
#echo $PROJECT_LIST
#
#for tenant in $PROJECT_LIST;
#do

    tenant=$PREFIX"_c"$1" "
    echo $tenant
    export OS_TENANT_NAME=$tenant
    echo "************* Processing project/router $tenant ***************"
#    i=$(echo $tenant | awk -F '[_c]' '{ print $4 }')
    ROUTER_ID=$(neutron router-list | grep "$tenant"  |  awk '{ print $2 }')
    echo Router ID: $ROUTER_ID


    FLAG=$( ssh controller1 cat /var/lib/neutron/ha_confs/$ROUTER_ID/state  )
    echo controller1 : $FLAG
    G=$( ssh controller2 cat /var/lib/neutron/ha_confs/$ROUTER_ID/state  )
    echo controller2 : $G
#    neutron router-port-list $ROUTER_ID | grep "123.$i" > tempfile.txt
#    NUM_LINE=$(cat tempfile.txt | wc -l )
#    
#    for x in `seq 1 $NUM_LINE`
#    do
#        port=$(tail -n $x tempfile.txt)
#        MAC_ADDR=$(echo $port | awk -F '[|]' '{print $4}')
#        IP_ADDR=$(echo $port | awk -F '[,]' '{print $2}' | awk -F '["]' '{print $4}')
#        VXLAN=$(ssh root@compute$i "arp -an | grep ${IP_ADDR:: -1}" | tail -n 1 | awk -F '[ ]' '{print $8}')
#        echo "MAC: $MAC_ADDR"
#        echo "IP : $IP_ADDR"
#        echo "VXLAN: $VXLAN" 
#        ssh root@compute$i "arp -s $IP_ADDR $MAC_ADDR -i $VXLAN"
#        ssh root@compute$i "arp -an | grep $IP_ADDR"
#    done

#    CONTROLLER=controller1
#    STATE=$(ssh root@$CONTROLLER "cat /var/lib/neutron/ha_confs/$ROUTER_ID/state")
#    if [ $STATE == "backup" ]; then
#        CONTROLLER=controller2
#        STATE=$(ssh root@$CONTROLLER "cat /var/lib/neutron/ha_confs/$ROUTER_ID/state")
#        if [ $STATE != "master" ]; then
#            echo "master not found for router $tenant"
#            CONTROLLER=""
#        fi
#    fi
#    echo "$CONTROLLER has master router"
#    ssh root@$CONTROLLER "ip netns exec qrouter-$ROUTER_ID ip a | #grep -A 2 qr-"


