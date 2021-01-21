#!/bin/bash


# Script utilizado para criar usuarios no servidor local, e nos servidores remotos.
# Lembre-se, qualquer aplicativo, arquivo que todos usuarios devam possuir coloca-lo
# dentro do diretorio /etc/skel

# Variaveis com ip dos servidores a criar o usuario

# Servidores oficiais
SERVERS="172."

# Use o abaixo para fazer testes
#SERVERS="10"

add_user(){
   # Zera contador
   count=0
   echo -ne "Informe nome do usuario\n"
   read NOME_USUA
   while [ -z "$NOME_USUA" ]; do
        echo -ne "Informe nome do usuario\n"
      read NOME_USUA
     done

   echo -ne "Informe a senha do usuario:\n"
   read SENHA_USU
   while [ -z "$SENHA_USU" ]; do
        echo -ne "Informe a senha do usuario:\n"
      read SENHA_USU

     done

   echo -ne "Vou assumir o grupo users para o usuario:$NOME_USUA\n"
   echo -ne "Adiconando $NOME_USUA em: $HOSTNAME\n"
   # Cria a conta no servidor local
   $(adduser $NOME_USUA -p $SENHA_USU -g users && echo $NOME_USUA:$SENHA_USU | chpasswd)

   # Cria a conta no servidores remotos
   for servs in $SERVERS ;do
      echo -ne "Adiconando $NOME_USUA"" em:$servs\n"
      sshpass -p "H&DCluster!" ssh root@$servs "adduser $NOME_USUA"" -p "$SENHA_USU" -g users && echo $NOME_USUA"":$SENHA_USU | chpasswd && exit "
      if [ $? == 0 ]; then
         count=$(expr $count + 1)
         else
         
         echo -ne "Erro ao criar conta em:$servs\n"
       fi
   done

   echo -e "Contas criadas:$count servidor[es]"

}


lock_user(){
   # Zera contador
   count=0
   echo -ne "Informe nome do usuario\n"
   read NOME_USUA
   while [ -z "$NOME_USUA" ]; do
        echo -ne "Informe nome do usuario\n"
      read NOME_USUA
     done
   for servs in $SERVERS ;do
      echo -ne "Bloqueando em: $servs\n"
      ssh root@$servs "usermod -L $NOME_USUA && exit"
      if [ $? == 0 ]; then
         count=$(expr $count + 1)
         else
         echo -ne "Erro ao bloquear conta em:$servs"
       fi
   done

   echo -e "Contas bloqueadas em:$count servidor[es]"
}


unlock_user(){
   # Zera contador
   count=0
   echo -ne "Informe nome do usuario\n"
   read NOME_USUA
   while [ -z "$NOME_USUA" ]; do
        echo -ne "Informe nome do usuario\n"
      read NOME_USUA
     done
   for servs in $SERVERS ;do
      echo -ne "Desbloqueando em: $servs\n"
      ssh root@$servs "usermod -U $NOME_USUA && exit"
      if [ $? == 0 ]; then
         count=$(expr $count + 1)
         else
         echo -ne "Erro ao desbloquear conta em:$servs"
       fi
   done

   echo -e "Contas desbloqueadas em:$count servidor[es]"

}

# Funcao menu de opcoes
menu(){

    clear
    echo -ne " Administrar usuarios\n"
    echo -ne " 1 - Adicionar usuario \n"
    echo -ne " 2 - Bloquear usuario \n"
    echo -ne " 3 - Desbloquear usuario \n"
    echo -ne " 4 - Sair \n"
    echo -ne " Pode-se usar ctrl+c para finalizar."
    echo -ne "\n ->"
    read OPCAO_SEL

    case $OPCAO_SEL in
         1) add_user
   ;;
   2) lock_user
   ;;
   3) unlock_user
   ;;
         4) clear; exit 0;
   ;;
         *)
    clear;
    echo -ne "Opcao invalida. Escolha 1,2,3 e 4"
    sleep 2
    menu
   ;;
    esac
}


if [ "$(id -u)" != "0" ]; then
   echo -e "Script deve ser executado com usuario root."
   else
   menu
fi

exit 0;
