#!/bin/bash

#Infraestrutura FNDE 
#Linux/Aplicações 

PID=`ps aux | grep jenkins | grep -v grep | awk '{print $2}'`

restartJenkins () {
echo "Parando processo jenkins, PID:" $PID
/etc/init.d/jenkins stop
echo "....."
echo "Iniciando processo jenkins"
/etc/init.d/jenkins start 

}

restartJenkins

if [ $? -eq 0 ]; then
    echo "Jenkins iniciado com sucesso."
 else 
    echo "Restart falhou." 
 fi
