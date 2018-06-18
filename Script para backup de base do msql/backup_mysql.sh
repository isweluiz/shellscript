#!/bin/bash
# Data de autoria: 17/06/2018 
# Autoria: Luiz Eduardo 
# Utilização: Dê permissão de execução para o script '$ chmod +x backup_mysql.sh' .Agende o script na crontab do seu usuário com permissão para execução 



if [ -e /var/log/wiki_backup.log ] ; then
	echo "Se o arquivo de log existir ele não criará o arquivo" >> /dev/null 
else 
	touch /var/log/wiki_backup.log 
fi 
LOG='/var/log/wiki_backup.log'
echo "--------------------------------------" >>$LOG
echo "Backup início:" `date` >>$LOG
echo "Definindo parametros do sistema" >>$LOG

DATE=`date +%Y-%m-%d`
MYSQLDUMP=/usr/bin/mysqldump
BACKUP_DIR=/opt/backup1234
BACKUP_NAME=nomedoarquivo-$DATE.sql
BACKUP_TAR=wikidb_backup-$DATE.tar

DB_NAME='dbnamee'
DB_USER='userrrr'
DB_PASS='passs'


echo "Gerando Backup da base de dados $DB_NAME em $BACKUP_DIR/$BACKUP_NAME " >>$LOG 
$MYSQLDUMP $DB_NAME -u $DB_USER -p$DB_PASS $DB_PARAM > $BACKUP_DIR/$BACKUP_NAME
echo "Compactando arquivos " >>$LOG 
gzip $BACKUP_DIR/$BACKUP_NAME & 

echo "Excluindo arquivos com mais de 30 dias de modificados"  >>$LOG
find $BACKUP_DIR/ -mtime +30 -delete & 

echo "Backup fim:" `date` >>$LOG
echo "--------------------------------------" >>$LOG 
