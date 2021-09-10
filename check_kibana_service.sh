#!/bin/bash 
PID=`ps aux | grep -i "kibana" | grep -v grep | awk '{print $2}'`

status_process () {
    echo "Processo Kibana SERVER: " $PID
}

status_process

if [ $? -eq 0 ]; then 
    echo "Kibana is running as well"
else 
    echo "Falha no processo, verificar manualmente."
fi 
