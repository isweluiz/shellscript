#!/bin/bash

service=$1
is_running=`ps aux | grep -v grep| grep -v "$0" | grep $service| wc -l | awk '{print $1}'`

if [ "$#" = 0 ]; then
    echo "Usage $0 "
    exit 1
fi

if [ $is_running != "0" ] ; then
    echo "Service $service is running"
else
    echo
    initd=`ls /etc/init.d/ | grep $service | wc -l | awk '{ print $1 }'`

if [ $initd = "1" ]; then
    startup=`ls /etc/init.d/ | grep $service`
    echo -n "Found startap script /etc/init.d/${startup}. Start it? Y/n ? "
    read answer
if [ $answer = "y" -o $answer = "Y" ];

then
    echo "Starting service..."
    /etc/init.d/${startup} start
fi
fi
fi
