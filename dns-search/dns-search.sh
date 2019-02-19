#!/bin/bash 
# Autor: L. E.
case "$1" in
        -v | --version) echo "domain-search 1.0  > blog.isweluiz.com" ; exit ;;
		-h | --help) echo "#./domain-search.sh globo.com word-list.txt" ; exit ;;	
esac
echo "[!] Este processo pode demorar um pouco dependendo da quantidade de palvras contidas na word list"
echo "[*] Realizando Enumeração Geral de Domínio: `$1`" 
for url in $(cat $2); do
	echo "[+]    " 
	host $url.$1 | grep -i "has addres"
done
