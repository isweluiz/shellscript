#!/bin/bash
#Autor: Luiz Eduardo
#linkedin:/www.linkedin.com/in/isweluiz/

#Descrição: O scipt facilitzken.sh é simplesmente simples :), apenas para automatizar a execução de arquivos json, deve-se apenas passar como primeiro parâmetro o arquivo json
#Funções até agora implantadas:
# - Automatizar a execução de arquivos json na api do zabbix
ARQUIVO="$1"
URL='http://zabbix.teste.br/zabbix/api_jsonrpc.php' #your zabbix url here
echo " " 
curl -s -X POST -H 'Content-Type:application/json' --data "@$ARQUIVO"  "$URL" | python -mjson.tool
echo " " 

