#!/bin/bash 
PID=`ps aux | grep -i "elastic" | grep -v grep | awk '{print $2}'`

status_process () {
    echo "Processo Elastic SERVER: " $PID
}

status_process

if [ $? -eq 0 ]; then 
    echo "Elastic is running as well"
else 
    echo "Falha no processo, verificar manualmente."
fi 
