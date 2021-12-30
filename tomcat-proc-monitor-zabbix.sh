#!/bin/bash

#Define ret_code
RET_ERR=2
RET_WARN=1
RET_OK=0

tomcat_proc=$(ps axuf | grep 'tomcat' | awk '{ print $2}' | wc -l)

if [ "$tomcat_proc" -gt 20 ]; then
    exit $RET_ERR
fi

if [ "$tomcat_proc" -gt 10 ]; then
    exit $RET_WARN
fi

exit $RET_OK
