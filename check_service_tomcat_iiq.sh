#!/bin/bash 
PID=`ps aux | grep -i "tomcat-juli.jar" | grep -v grep | awk '{print $2}'`

check_kill () {
    echo "Processo IIQ SERVER: " $PID
    echo "Parando processo"
    sudo systemctl stop tomcat 
}


start_tomcat () {
    echo "Iniciando processo IIQ SERVER"
    sudo systemctl start tomcat
}

check_kill
start_tomcat

if [ $? -eq 0 ]; then 
    echo "IIQ server iniciado com sucesso."
else 
    echo "Restart falhou."
fi 

check_pid2 () {
    PID2=`ps aux | grep -i "tomcat-juli.jar" | grep -v grep | awk '{print $2}'`
    echo "Novo processo IIQ SERVER: " $PID2
}

check_pid2
