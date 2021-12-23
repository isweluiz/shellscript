#!/bin/bash 

unistall_tower () {
echo "Shut down Tower services by running"
ansible-tower-service stop
echo "Uninstall ansible-tower packages"
yum -y remove ansible-tower\*
echo "Uninstall RabbitMQ:"
yum -y remove rabbitmq-server
echo "Delete Tower data/configuration files"
rm -rf /etc/tower /var/lib/{pgsql,awx,rabbitmq}
}
unistall_tower
if [  $? = 0 ]
then 
echo "Unistall successfull..."
else 
echo "Unistall failed,please check manual..."
fi 
