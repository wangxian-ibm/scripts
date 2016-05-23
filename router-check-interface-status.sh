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
BOTH=0
NUM_ARP=0
NUM_BUILD=0
NUM_INTERFACE=0
for tenant in $PROJECT_LIST;
do
    export OS_TENANT_NAME=$tenant
    i=$(echo $tenant | awk -F '[_c]' '{ print $4 }')
    echo ""
    echo "************* Processing project $tenant : router $i ***************"
    export OS_TENANT_NAME=$tenant
#    ROUTER_ID=$(neutron router-list | grep "default " |  awk '{ print $2 }')
    ROUTER_ID=$(neutron router-list | grep "$tenant " |  awk '{ print $2 }')
    echo Router ID: $ROUTER_ID

    neutron router-port-list $ROUTER_ID | grep "subnet_id" | grep -v "HA" > tempfile.txt
    NUM_LINE=$(cat tempfile.txt | wc -l )
    
    for x in `seq 1 $NUM_LINE`
    do
        port=$(tail -n $x tempfile.txt)
        PORT_ID=$(echo $port | awk '{print $2}')
        MAC_ADDR=$(echo $port | awk -F '[|]' '{print $4}')
        IP_ADDR=$(echo $port | awk -F '[,]' '{print $2}' | awk -F '["]' '{print $4}')
        echo "Port ID: $PORT_ID"
        FLAG_BUILD=$(neutron port-show $PORT_ID | grep BUILD | wc -l)
        if [ $FLAG_BUILD -eq 1 ] ; then
            echo "    Router status is in BUILD"
            NUM_BUILD=$(($NUM_BUILD + 1))
        fi

        #echo "MAC: $MAC_ADDR"
        echo "IP : $IP_ADDR  --- MAC: $MAC_ADDR"
        ssh root@compute1 "arp -an | grep $IP_ADDR | grep $MAC_ADDR"
        FLAG_ARP=$(ssh root@compute1 "arp -an | grep $IP_ADDR | grep $MAC_ADDR | wc -l")
        if [ $FLAG_ARP -lt 1 ] ; then
            echo "    ARP entry does not exist....... ERROR"
            NUM_ARP=$(($NUM_ARP + 1))
        fi

        if [ $FLAG_BUILD -eq 1 ] && [ $FLAG_ARP -lt 1 ] ; then
            echo "    BOTH arp and router interface failed"
            BOTH=$(($BOTH + 1))
        fi
        NUM_INTERFACE=$(($NUM_INTERFACE + 1))
    done
done

echo "
NUM ARP MISSING : $NUM_ARP
NUM BUILD       : $NUM_BUILD
BOTH fail at same time: $BOTH 
NUM INTERFACE   : $NUM_INTERFACE
"


