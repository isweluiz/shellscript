#!/bin/bash
# "Istall Zabbix-Agent"
(date +"%T";echo "-";hostname)|tr '\n' '\t' >> /tmp/ZabbixLog.txt

val=$(ps -aux 2>/dev/null | grep -i zabbix_agentd | grep -v grep | wc -l)
path=$(ps -aux 2>/dev/null | grep -i zabbix_agentd | grep -v grep | grep -i zabbix_agentd.conf | awk {'print $10'})
srv=$(cat "$path" | grep "Server=" | grep -v "#")
host=$(cat "$path" | grep "Hostname=" | grep -v "#")

if [ "$val" = 0 ];
   then
      (date +"%T";echo "-";echo "Seta proxy")|tr '\n' '\t' >> /tmp/ZabbixLog.txt
      export http_proxy=http://webcache.fnde.gov.br:8080
      export https_proxy=https://webcache.fnde.gov.br:8080
      (date +"%T";echo "-";echo "Seta repo.zabbix")|tr '\n' '\t' >> /tmp/ZabbixLog.txt
      rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
      (date +"%T";echo "-";echo "Instala Zabbix-Agent")|tr '\n' '\t' >> /tmp/ZabbixLog.txt
      yum install -y zabbix-agent
      (date +"%T";echo "-";echo "Seta parametros no zabbix_agentd.conf")|tr '\n' '\t' >> /tmp/ZabbixLog.txt
      sed -i s/"Server=127.0.0.1"/"Server=172.20.65.103"/g /etc/zabbix/zabbix_agentd.conf
      sed -i s/"Hostname=Zabbix server"/"#Hostname=Zabbix server"/g /etc/zabbix/zabbix_agentd.conf
      sed -i s/"# HostnameItem=system.hostname"/"HostnameItem=system.hostname"/g /etc/zabbix/zabbix_agentd.conf
      (date +"%T";echo "-";echo "Enable Zabbix-Agent")|tr '\n' '\t' >> /tmp/ZabbixLog.txt
      systemctl enable zabbix-agent
      chkconfig zabbix-agent on
      (date +"%T";echo "-";echo "Start Zabbix-Agent")|tr '\n' '\t' >> /tmp/ZabbixLog.txt
      systemctl start zabbix-agent
      /etc/init.d/zabbix-agent restart
   else
      (date +"%T";echo "-";echo "Seta parametros no zabbix_agentd.conf")|tr '\n' '\t' >> /tmp/ZabbixLog.txt
      sed -i s/""$srv""/"Server=172.20.65.103,"/g "$path"
      sed -i s/"# HostnameItem=system.hostname"/"HostnameItem=system.hostname"/g "$path"
      sed -i s/""$host""/"#"$host""/g "$path"
      (date +"%T";echo "-";echo "Restart Zabbix-Agent")|tr '\n' '\t' >> /tmp/ZabbixLog.txt
      /etc/init.d/zabbix-agent restart
      systemctl restart zabbix-agent
fi
[ro