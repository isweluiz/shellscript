#!/bin/bash
#Autor: Luiz Eduardo
#Linkedin: www.linkedin.com/in/isweluiz/

#Descrição: O script AUTOMATIZKEN.sh tem o intuito de agilizar a geração de token e realização de buscas em json na api do zabbix.
#Funções até agora implantadas:
# - Gerar TOKEN
# - Executar funções da api (NO)
# - Verificar versão do zabbix

Data=`date +%d-%m-%Y-%H-%M`
Whoami=`whoami`
URL='http://zabbix.teste.jus.br/zabbix/api_jsonrpc.php' #Url do seu zabbix
USER='"user"' #Usuário para acessar o zabbix
PASS='"pass"' #Senha para acessar o zabbix
arq_log="/var/log/geradordetoken.log" #Diretório onde será armazedo o log
echo "------------------+-----------------------" >> $arq_log
echo "Executado em:"$Data >> $arq_log
echo "Usuário:"$Whoami >> $arq_log
echo "------------------+-----------------------" >> $arq_log
case "$1" in
	--h | -help) echo "Execute o script e digite a opção desejada." ; exit ;;
	-v | --version) echo "Gerador de token para autenticação V0.1" ; exit ;;
esac
Menu() #Função menu
{
echo "------------------+-----------------------"
echo "    GERADOR DE TOKEN PARA API DO ZABBIX"
echo "------------------+------------------------"
echo "[1] Gerar token"
echo "[2] Versão da API"
echo "[3] Sair"
echo -n "Digite a opção desejada:"
read gerar_opcao
case "$gerar_opcao" in 
	1) Gerar;;
	2) versao_api ;;
	3) exit;;
	*)
	echo "Opção desejada desconhecida" ; Menu ;;
esac
}
token=$Gerar 
Gerar(){ 
	JSON='
{
	"jsonrpc": "2.0",
	"method": "user.login",
	"id": 0,
	"auth": null,
	"params": {
		"user": '$USER', #Armazena o usuário
		"password": '$PASS' #Armazena a senha
	}
}'
	echo "------------------+----------------------------"
	echo -n "Token obtido:" ; curl -s -X POST -H 'Content-Type: application/json' --data "$JSON" "$URL" | cut -d '"' -f8  
	echo "------------------+----------------------------"
	echo ""
	echo -n "Voltar ao menu [s/n]:" 
	read volta_menu
		case "$volta_menu" in
			s | S) Menu;;
			n | N) exit;;
			*)
				echo "Opção desconhecida" ; exit;;
		esac
}
versao_api(){
	JSONV='
{
	"jsonrpc": "2.0",
	"method": "apiinfo.version",
	"params":[],
	"id":1
}'
	echo "------------------+----------------------------"
	echo -n "Versão:" ; curl -s -X POST -H 'Content-Type: application/json' --data "$JSONV" "$URL" | python -mjson.tool
	echo "------------------+----------------------------"
	echo -n "Voltar ao menu [s/n]:"
	read volta_menu
		case "$volta_menu" in
			s | S) Menu;;
			n | N) exit;;
			*)
				echo "Opção desconhecida" ; exit;;
		esac
}
Menu


