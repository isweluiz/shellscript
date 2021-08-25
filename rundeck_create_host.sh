#!/bin/bash

echo "Valores informados:"
echo "Host:" @option.host@
echo "Ambiente:" @option.ambiente@
echo "Descricao:" @option.descricao@
echo "Tag:" @option.tags@
echo "osName:" @option.osName@
echo "OsVersion:" @option.osversion@ 

#Functions
cadastroHostProd() {
echo "Cadastrando Hosts em ambiente de producao..."
sleep 2


sed  -i "/\/project\>/d" /var/lib/rundeck/nodes/nodes.xml

cat <<EOF >> /var/lib/rundeck/nodes/nodes.xml
<node name="@option.host@" description="@option.descricao@" tags="@option.tags@" hostname="@option.host@" osArch="amd64" osFamily="unix" osName="@option.osName@" osVersion="@option.osversion@" username="root"/>
</project>
EOF


#Condicional de validacao
if [ $? -eq 0 ]; then
    echo "Cadastro realizado com sucesso."
 else 
    echo "Cadastro falhou." 
 fi
}

#Condicional para execucao das funcoes 
case @option.ambiente@ in
    PROD) cadastroHostProd ;;
    HMG) cadastroHostHmg ;;
    DEV) cadastroHostDev ;;
	 QA) cadastroHostQA ;;
      *)  exit ;;
esac
