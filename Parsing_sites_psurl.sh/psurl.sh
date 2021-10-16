#!/bin/bash
# Autor: L. Eduardo (axur_pas)
echo "   _____                  __                 __________                   .__               ";
echo "  /     \ _____    ______/  |_  ___________  \______   _____ _______ _____|__| ____   ____  ";
echo " /  \ /  \ \__  \  /  ___\   ___/ __ \_  __ \  |     ___\__ \ \_  __ /  ___|  |/    \ / ___\ ";
echo "/    Y    \/ __ \_\___ \ |  | \  ___/|  | \/  |    |    / __ \|  | \ \___ \|  |   |  / /_/  >";
echo "\____|__  (____  /____  >|__|  \___  |__|     |____|   (____  |__| /____  |__|___|  \___  / ";
echo "        \/     \/     \/           \/                       \/          \/        \/_____/  ";
echo "........................................................................blog.isweluiz.com.br";
echo " "
case "$1" in
        -v | --version) echo "Master Parsing Site  > blog.isweluiz.com" ; exit ;;
esac
echo "Ex de utilização -  Declare o site:www.globo.com.br"
echo " "
echo -n "Declare o site: "
read  url
if [ -z $url ]; then
        echo "Execute o script novamente passando a URL"
else
        wget -nv $url
        echo " "
        echo ";............................................."
        echo "Buscando hosts"
        sleep 1
        echo " "; grep "href" index.html  | cut -d "/" -f3 | grep "\." | cut -d '"' -f1 | sort -u | egrep  ".com.br|.com|.br|.jus.br|.gov.br|.net|.org" |egrep -v "_|blank|target_" | grep -v "<li"
        echo ";............................................."
        echo "Resolvendo hosts"
        sleep 1
        echo " "; grep  "href" index.html  | cut -d "/" -f3 | grep "\." | cut -d '"' -f1 | sort -u | egrep  ".com.br|.com|.br|.jus.br|.gov.br|.net|.org"|egrep -v "_black|target_"  | grep -v "<li" > lista
        for x in $(cat lista); do host $x; done | grep "has address"
fi
rm -rf index*
rm -rf lista