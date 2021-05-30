#!/bin/bash
X=1 
init_script="https://raw.githubusercontent.com/isweluiz/wso2/main/wso2"
service="https://raw.githubusercontent.com/isweluiz/wso2/main/wso2.service"
wso2_s3="https://lab-tec.s3.amazonaws.com/wso2am-3.2.0.zip"

InstallWso2 () {
#Install java and wget
yum install -y java wget 

#Download wso2
mkdir /opt/apm/ 
wget $wso2_s3 -O /opt/apm/wso2am-3.2.0.zip

#Configuring directory wso2
cd /opt/apm/ 
unzip wso2am-3.2.0.zip
ln -s /opt/apm/wso2am-3.2.0 /opt/apm/wso2
useradd -r wso2
chown -R wso2:wso2 /opt/apm/

#Download init script 
wget $init_script -O /etc/init.d/wso2
chmod +x /etc/init.d/wso2

#Download service 
wget $service -O /etc/systemd/system/wso2.service
systemctl daemon-reload

#configuring IP EC2
ip="$(curl -s ifconfig.me | awk "{print $1}")"
cp -Rp /opt/apm/wso2/repository/conf/deployment.toml /opt/apm/wso2/repository/conf/deployment.toml.bkp
sed -i "s/localhost/$ip/g" /opt/apm/wso2/repository/conf/deployment.toml
systemctl enable wso2
systemctl start wso2
}

CreateAlias () {
echo alias wso2-logs='"tail -f /opt/apm/wso2/repository/logs/wso2carbon.log"' >>  ~/.bashrc
echo alias startcmd='"${API_M_HOME}/bin/wso2server.sh start > /dev/null &"' >>  ~/.bashrc
echo alias restartcmd='"${API_M_HOME}/bin/wso2server.sh restart > /dev/null &"' >>  ~/.bashrc
echo alias  stopcmd='"${API_M_HOME}/bin/wso2server.sh stop > /dev/null &"' >>  ~/.bashrc
source ~/.bashrc
}

CreateMotd () {
cat << EOF > /etc/motd 
        EC2 - LAB
        WSO2 API MANAGER
        Manage service WSO2 APM
        ---
        systemctl start wso2
        systemctl stop wso2
        wso2-logs
        ---
        Install dir
        /opt/apm/wso2
EOF
}

for job in $X; do
    InstallWso2
    CreateAlias

  if [ $? -eq 0 ]; then
    echo "WSO2 installed with sucessfull." >> /opt/wso2-install.out
  else 
    echo "Install failed."  >> /opt/wso2-install.out
  fi
done
