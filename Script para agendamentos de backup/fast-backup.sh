#!/bin/bash
for ORIGEM in `cat $1`
do
        DATA=`date +%Y-%m-%d-%H-%M` #Armazena a data - ANO - MÊS - DIA - HORA - MINUTO 
        NOMEFILE=`echo $ORIGEM | sed 's|/|_|g' |sed '1 s|_||'` #NOMEFILE recebe o nome do arquivo ORIGEM e manipula com o comando sed, trocando as "/" por "_" 
        tar czf $2/${NOMEFILE}_$DATA.tar.gz $ORIGEM   #Cria o arquivo compactado com tar.gz - $2 armazena o destino "/" omite o ${NOMEFILE}
        touch $HOME/fast-backup/fast-backup.log #Cria o arquivo de log no diretório home do usuário 
		echo "======================================================="
		echo "INICIO DE EXECUÇÃO:" $DATA >> $HOME/fast-backup/fast-backup.log #LOGS de execução 
        echo "Arquivo/Diretório de origem:$ORIGEM" >> $HOME/fast-backup/fast-backup.log
		echo "Local de destino:$2 Em: $DATA" >> $HOME/fast-backup/fast-backup.log #LOGS de execução
		echo "======================================================="
done
exit 
