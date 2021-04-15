#!/bin/bash
LOG="/opt/check_juris/check.out"
echo "---------------------------" >> $LOG
echo "Check `date`" >> $LOG

check_url=`curl -kvL  https://www.jus.br/jurisprudencia  2>&1 | grep -i 'HTTP/1.1 ' | awk '{print $3}'| sed -e 's/^[ \t]*//' | grep -E '200|404'`

restart_sg () {
/data/jboss-eap-6.4/bin/jboss-cli.sh --controller=host.local -c --user=****** --password==****** --commands="/server-group=sg_juris:restart-servers(blocking=true)" >> ./check-juris.out
}

action_check () {
if [ $check_url -eq 200 ]
then
  echo "Juris UP" >> $LOG
  echo "---------------------------" >> $LOG
else
  echo "Juris Down" >> $LOG
  echo "Reiniciando servers" >> $LOG
  restart_sg
  echo "---------------------------" >> $LOG
fi
}
action_check
