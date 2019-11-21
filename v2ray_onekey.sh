#!/bin/bash
clear
echo
echo "#################################################################"
echo "django-sspanel V2ray 一键后端"
echo
echo "System Required: CentOS 7 "
echo "#################################################################"
echo


system_check

system_check(){
	if [ -f /usr/bin/yum ]; then
		centos_install
	#elif [ -f /usr/bin/apt ]; then
		#debian_install
	else
		echo -e "你的系统不支持"
	fi
}

APIinit(){
echo "请输入面板地址(Example:sspanel.com)"
read Domain
echo "请输入Token"
read Token
echo "请输入节点ID"
read NodeId
API="\"http:\/\/$Domain\/api\/user_ss_config\/$NodeId\/?token=$Token\""
}

centos_install(){
    APIinit
    echo $API
    yum install -y curl git
    curl -sSL https://get.docker.com/ | sh
    curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    systemctl restart docker
    git clone https://github.com/Ehco1996/v2scar.git
    cd v2scar
    docker-compose up -d

}










