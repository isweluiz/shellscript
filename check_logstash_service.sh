#!/bin/bash 
PID=`ps aux | grep -i "logstash" | grep -v grep | awk '{print $2}'`

status_process () {
    echo "Processo Logstash: " $PID
}

status_process

if [ $? -eq 0 ]; then 
    echo "Logstash is running as well"
else 
    echo "Falha no processo, verificar manualmente."
fi 
