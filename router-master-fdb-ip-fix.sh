source /root/stackrc
PREFIX=unicorn
PROJECT_OUTPUT=$(keystone tenant-list | grep $PREFIX )
PROJECT_LIST=""
for item in $PROJECT_OUTPUT;
do
   PROJECT_LIST="$PROJECT_LIST $(echo $item | grep $PREFIX)"
done

echo "Project List:"
echo $PROJECT_LIST


for tenant in $PROJECT_LIST;
do

    export OS_TENANT_NAME=$tenant
    i=$(echo $tenant | awk -F '[_c]' '{ print $4 }')
    echo ""
    echo "************* Processing project $tenant : compute $i ***************"
    export OS_TENANT_NAME=$tenant
    ROUTER_ID=$(neutron router-list | grep "$tenant " |  awk '{ print $2 }')
    echo Router ID: $ROUTER_ID

    CONTROLLER=10.130.101.138
    BACKUP=10.130.101.139
    STATE=$(ssh root@$CONTROLLER "cat /var/lib/neutron/ha_confs/$ROUTER_ID/state")
    if [ $STATE == "backup" ]; then
        CONTROLLER=10.130.101.139
        BACKUP=10.130.101.138
        STATE=$(ssh root@$CONTROLLER "cat /var/lib/neutron/ha_confs/$ROUTER_ID/state")
        if [ $STATE != "master" ]; then
            echo "Master not found for router $tenant"
            exit 0
        fi
    fi
    echo "$CONTROLLER has master router"

    FIRST_VXLAN="vxlan-"$(openstack network show $tenant"_1" | grep segmentation_id | awk '{ print $4 }')
    SEC_VXLAN="vxlan-"$(openstack network show $tenant"_2" | grep segmentation_id | awk '{ print $4 }')
    echo "FIRST VXLAN: $FIRST_VXLAN" 
    echo "SEC   VXLAN: $SEC_VXLAN"

    FIRST_IP="123."$i".1.1"
    SEC_IP="123."$i".2.1"
    echo "FIRST IP: $FIRST_IP" 
    echo "SEC   IP: $SEC_IP"

    FIRST_MAC=$(ssh root@compute$i "arp -an | grep $FIRST_IP" | awk '{ print $4 }')
    SEC_MAC=$(ssh root@compute$i "arp -an | grep $SEC_IP" | awk '{ print $4 }')
    echo "FIRST MAC: $FIRST_MAC" 
    echo "SEC   MAC: $SEC_MAC"
 
    ssh root@compute$i "bridge fdb show | grep $FIRST_VXLAN | grep $FIRST_MAC | grep $BACKUP" > vxlan-fdb.txt
    ssh root@compute$i "bridge fdb show | grep $SEC_VXLAN | grep $SEC_MAC | grep $BACKUP" >> vxlan-fdb.txt

    sed -i -e 's/^/bridge fdb delete /' vxlan-fdb.txt  
    sed -i -e 's/$/;/' vxlan-fdb.txt
    cat vxlan-fdb.txt
    cat vxlan-fdb.txt | ssh root@compute$i

    ssh root@compute$i "bridge fdb add $FIRST_MAC dev $FIRST_VXLAN dst $CONTROLLER self permanent"
    ssh root@compute$i "bridge fdb add $SEC_MAC dev $SEC_VXLAN dst $CONTROLLER self permanent"

done

rm vxlan-fdb.txt
