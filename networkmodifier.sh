sed -i '/virt_type/c\virt_type=kvm' /etc/nova/nova.conf
service nova-compute restart
