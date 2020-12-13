#!/bin/bash

undeploy() {
   echo -n "[UNDEPLOY] Procurando por versoes anteriores... "
   $JBOSS_HOME/bin/jboss-cli.sh -c --controller=caratinga00.fnde.gov.br <<EOF
undeploy $WAR_FILE --all-relevant-server-groups
EOF
   undeploy_status=$(echo $?);
   return $undeploy_status
}

deploy() {
   $JBOSS_HOME/bin/jboss-cli.sh -c --controller=caratinga00.fnde.gov.br <<EOF
deploy $JBOSS_HOME/domain/deploy-queue/$WAR_FILE --server-groups=$INSTANCE_NAME
EOF
   deploy_status=$(echo $?);
   return $deploy_status
}

pause() {
   if [ $DEBUG -eq 1 ]; then
#      read -p "*DEBUG* Press any key to continue..."
       debug;
   fi
}

debug() {
   if [ $DEBUG -eq 1 ]; then
      echo $WAR_FILE
      echo $BACKUP
      echo $REBOOT
      echo $INSTANCE_NAME
   fi
}

restart() {
   echo -n "[DEPRECATED] Ignorando"
}

BACKUP=0
REBOOT=0
DEBUG=0

set -x

if [ $# -lt 2 ]; then
   echo -e "Uso: $0 -f <file> [-i instance] [-s][-b][-r][-d]"
   echo -e "-f arquivo da aplicacao"
   echo -e "-s deploy de datasource - Deprecated"
   echo -e "-b realizar backup - Deprecated"
   echo -e "-r reiniciar o jboss ao final - Deprecated"
   echo -e "-d modo debug"
   exit 1
fi

while getopts ":f:i:sbrd" opt; do
    case $opt in
      f)
        WAR_FILE=$OPTARG
        if [ x$WAR_FILE == "x-i" ];     then
            echo -e "Informe o nome do arquivo"
            exit 1
        fi
        ;;
      i)
        INSTANCE_NAME=$OPTARG
        ;;
      s)
        #DS_FILE=`echo $WAR_FILE | awk -F.war '{print $1"-ds.xml"}'`
        echo "[DEPRECATED] Opcao invalida: -s: Ignorando" >&2
        ;;
      b)
        #BACKUP=1
        echo "[DEPRECATED] Opcao invalida: -b: Ignorando" >&2
        ;;
      r)
        #REBOOT=1
        echo "[DEPRECATED] Opcao invalida: -r: Ignorando" >&2
        ;;
      d)
        DEBUG=1
        ;;
      ?)
        echo "Opcao invalida: -$OPTARG" >&2
        exit 1
        ;;
      :)
        echo "-$OPTARG requer um argumento." >&2
        exit 1
        ;;
    esac
done

JBOSS_HOME=/opt/jboss-eap-6.4
if [ x$INSTANCE_NAME == "x" ]; then
   echo "[INSTANCIA] Configurando instancia"
   $JBOSS_HOME/bin/jboss-cli.sh -c --controller=caratinga00.fnde.gov.br > /tmp/deploy.$WAR_FILE.info <<EOF
   deployment-info --name=$WAR_FILE
EOF
   INSTANCE_NAME=$(cat /tmp/deploy.$WAR_FILE.info|grep "enabled" | cut -f1 -d" ")
fi


debug

cd $DEPLOY_DIR

# main
undeploy $WAR_FILE
pause
deploy $WAR_FILE $INSTANCE_NAME
pause

if [ $deploy_status -eq 0 ]; then
   echo -e "[SUCESSO]\n"
else
   echo -e "[FALHOU]\n"
fi

rm -f $BOOT_LOCK_FILE > /dev/null 2>&1
echo "[exit] status $deploy_status"
exit $deploy_status
