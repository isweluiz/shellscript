#!/bin/sh

## Variáveis Jboss 
user=rundeck
pass=""
stop_servers="/server-group=sg_des_espacoservidor2:start-servers()"
undeploy="undeploy des_portalservidor.war --server-groups=sg_des_espacoservidor2"
deploy="deploy /var/lib/rundeck/GerenciarDeConfiguracaoCJF/harpia_eap73/desenvolvimento/pacotes/deploy/des_portalservidor.war --server-groups=sg_des_espacoservidor2 --runtime-name=portalservidor.war --enabled"
domain_controller="harpia01.cjf.local"
X=1 
## Variáveis artefato 
destino_artefato="/var/lib/rundeck/GerenciarDeConfiguracaoCJF/harpia_eap73/desenvolvimento/pacotes/deploy"
artefato_name="des_portalservidor.war"

if [ -d $destino_artefato ] 
then 
   echo "Diretório destino ok... "
else 
     mkdir -p $destino_artefato 
fi

copiaArtefato () {
    echo "Efetuado copia do artefato..."
    rm -rf  $destino_artefato/*.war 
    cp -Rf @file.WAR@ $destino_artefato/@file.WAR.fileName@
    echo "Renomeando para o artefato para des_portalservidor.war..."
    mv $destino_artefato/@file.WAR.fileName@  $destino_artefato/$artefato_name
    
} 

deployPortal () { 
    echo "Inciando todas as instâncias do grupo sg_des_espacoservidor2 para evitar falha no deploy..."
    echo " "
    
    /var/lib/rundeck/jboss/jboss-eap-7.3/bin/jboss-cli.sh --controller=$domain_controller:9990 -c -u=$user -p=$pass --command="$stop_servers"
    echo "Realizando undeploy..."
    echo " "
    
    /var/lib/rundeck/jboss/jboss-eap-7.3/bin/jboss-cli.sh --controller=$domain_controller:9990 -c -u=$user -p=$pass --command="$undeploy"
    echo "Realizando deploy..."
    echo " "
    /var/lib/rundeck/jboss/jboss-eap-7.3/bin/jboss-cli.sh --controller=$domain_controller:9990 -c -u=$user -p=$pass --command="$deploy"
    
    sleep 5 
    rm -rf  /var/lib/rundeck/GerenciarDeConfiguracaoCJF/harpia_eap73/desenvolvimento/pacotes/deploy/*.war 
} 

for job in $X; do
    copiaArtefato
    deployPortal

  if [ $? -eq 0 ]; then
    echo "Deploy concluído com sucesso."
  else 
    echo "Falha na execução do deploy." 
  fi
done
