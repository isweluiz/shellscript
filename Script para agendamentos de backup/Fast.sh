#!/bin/bash
case "$1" in 
        --h | -help) less ./help ; exit ;;  
        -v | --version) echo "Fast-Backup Versão 1.0" ; exit ;; 
esac 
#Script para agendamento de backup 
#ORIGEM / ARQ OU DIR DE ORIGEM 
#DESTINO / ARQ OU DIR DE DESTINO
DATA=$(date +%Y-%m-%d-%H-%M)
MINUTO="*" #Armazena o min pra exec do bkp 
HORA="*"  #Armazena hr pra exc do bkp 
DIAMES="*" #Armazena o dia do mês a ser executado    
MES="*"     #Determina o mês de execução do backup
DIASEM="*"   #Determina o dia da semana para execução do backup
REPETICAO="s" #Recebe o parametro para repetir o script 
if [ -d ./origens ]; then
        echo "OK " >> /dev/null
else 
        mkdir ./origens
fi
ORIBKP=`date +%Y-%m-%d-%Hh%M`".backup"  
touch $ORIBKP  #Cria um arquivo que irá armazenar os diretórios do backup 
if [ -d ./logs ] ; then 
        echo "ok"   >/dev/null # Joga pra lugar nenhum
 else 
 mkdir ./logs #Cria um diretório de LOG local
fi 
if [ -e ./logs/Agendamentos.log ] ; then # Se existir 
        echo "Ok" >/dev/null                             # Joga pra lugar nenhum
else 
        touch ./logs/Agendamentos.log            # Se n ele cria
fi 
LOG_LOCAL="./logs/Agendamentos.log" #A variável LOG_LOCAL recebe o diretório Agendamentos.log como valor 
echo "=======================================================" >> $LOG_LOCAL  #Armazena em log 
echo "INICIO DE EXECUÇÃO:  $DATA"  >> $LOG_LOCAL #Armazena em log
echo "Usuário:" `whoami`  >> $LOG_LOCAL #Armazena em log
echo "A partir do dir:" `pwd` >> $LOG_LOCAL          #Armazena em log

#       info (){
while [ $REPETICAO == "s" ]
do
                echo -n "Informe a origem do arquivo ou diretório:"  
                read ORIGEM # ARQ OU DIR DE ORIGEM 
                echo $ORIGEM >>./$ORIBKP # O conteudo da variável ORIGEM e direcionado para ORIBKP 
                echo -n "Deseja adicionar mais arquivos ou diretórios[s/n]?"
                read REPETICAO

#info
done
#} 
#info
Menu(){
echo -n "Informe o destino para armazenar o backup:"
read DESTINO  # Arm o caminho do destino do backup 
echo -n "Informe a quantidade:"
read QNTDIR #Armazena a quantidade de diretórios que serão armazenados após o agendamento de backup
echo "" #Linha em branco
echo "Seu agendamento está quase concluído!"
echo "Com que frequência você deseja que o backup seja efetudo?"
echo "[1]-Diário"
echo "[2]-Semanal"
echo "[3]-Mensal"
echo "[4]-Sair"
echo -n "Qual a opção desejada? "
read frequenciabackup           # Estipula a frequência de execução do backup 

case $frequenciabackup in 
        1) Diario ;; 
        2) Semanal ;; 
        3) Mensal ;; 
        4) exit ;; 
        *) echo  "Opção desconhecida" ; frequenciabackup ;;  # Caso o usuário informe uma opção diferente da 1-4 ele retornará para o menu frequenciabackup
esac 
}
#frequenciabackup
#Abaixo os blocos de funções que serão executados de acordo com a opção selecionada
Diario() {
        echo "Preencha as informações abaixo referente a dia e horário para execução do backup programado"
        echo -n "Hora que o backup será executado:"
        read HORA
        echo -n "Minuto que o backup será executado:"
        read MINUTO
        echo "Backup diário agendado"   >> $LOG_LOCAL  #Armazena em log
        echo "=======================================================" >> $LOG_LOCAL #Armazena em log
        echo "+" >> $LOG_LOCAL #Armazena em log
        echo "+" >> $LOG_LOCAL #Armazena em log

}
Semanal(){
        echo "Preencha as informações abaixo referente a dia e horário para execução do backup programado"
        echo -n "Hora que o backup será executado:"
        read HORA
        echo -n "Minuto que o backup será executado:"
        read MINUTO
        echo  "Dia da semana que o backup será executado"
        echo   "0 - Domingo"
        echo   "1 - Segunda-feira"
        echo   "2 - Terça-fiera"
        echo   "3 - Quarta-feira"
        echo   "4 - Quinta-feira"
        echo   "5 - Sexta-feira"
        echo   "6 - Sábado"
        echo ""
        echo   -n "Qual o dia desejado?:"
        read DIASEM
        echo "Backup semanal agendado"  >> $LOG_LOCAL  #Armazena em log
        echo "=======================================================" >> $LOG_LOCAL #Armazena em log
        echo "+" >> $LOG_LOCAL #Armazena em log
        echo "+" >> $LOG_LOCAL #Armazena em log
}
Mensal (){
        echo "Preencha as informações abaixo referente a dia e horário para execução do backup programado"
        echo -n "Hora que o backup será executado:"
        read HORA
        echo -n "Minuto que o backup será executado:"
        read MINUTO
        echo  "Dia da semana que o backup será executado"
        echo   "0 - Domingo"
        echo   "1 - Segunda-feira"
        echo   "2 - Terça-fiera"
        echo   "3 - Quarta-feira"
        echo   "4 - Quinta-feira"
        echo   "5 - Sexta-feira"
        echo   "6 - Sábado"
        echo ""
        echo   -n "Qual o dia desejado?:"
        read DIASEM
        echo "Backup mensal agendado"   >> $LOG_LOCAL 
        echo "=======================================================" >> $LOG_LOCAL
        echo "+" >> $LOG_LOCAL
        echo "+" >> $LOG_LOCAL
}

Menu
crontab -l > crontab.backup  #Armazeno o conteudo do crontab no crontab.backup 
echo "$MINUTO $HORA $DIAMES $MES $DIASEM $HOME/fast-backup/fast-backup.sh $HOME/fast-backup/origens/$ORIBKP $DESTINO $QNTDIR" >> crontab.backup  #Concateno as variaveis no crontab.backup   o $HOME/backup/backup.sh será incluído no crontab para a execução na hora e estabelecida
crontab < crontab.backup #Utilizo o crontab recebendo como entrada o conteudo do arquivo crontab.backup 
rm crontab.backup #Exclui o crontab.backup  
mv $ORIBKP origens
echo -n "Deseja realizar mais agendamentos?[S/n]"
read -r agendamento
case $agendamento in 
        S|s) Menu ;; 
        N|n) echo "SAIR" ; exit 0 ;; 
esac 