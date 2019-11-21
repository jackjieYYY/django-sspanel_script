#!/bin/bash
clear
echo
echo "#################################################################"
echo "django-sspanel v2ray 一键后端"
echo
echo "System Required: CentOS Debian"
echo "#################################################################"
echo


system_check(){
	if [ -f /usr/bin/yum ]; then
		centos_install
	elif [ -f /usr/bin/apt ]; then
		debian_install
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
API="\"http:\/\/$Domain\/api\/user_vmess_config\/$NodeId\/?token=$Token\""
echo "API = http://$Domain/api/user_vmess_config/$NodeId/?token=$Token"
echo "按任意键开始安装"
read A
}

End(){
echo "安装完毕 请打开防火墙 10086 端口"
echo "请按任意键退出脚本"
read A
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
    sed -i 's/V2SCAR_API_ENDPOINT: \"\"/V2SCAR_API_ENDPOINT: '"$API"'/g' docker-compose.yml
    docker-compose up -d
	End
}

debian_install(){
    APIinit
    echo $API
    apt install -y curl git
    curl -sSL https://get.docker.com/ | sh
    curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    systemctl restart docker
    git clone https://github.com/Ehco1996/v2scar.git
    cd v2scar
    sed -i 's/V2SCAR_API_ENDPOINT: \"\"/V2SCAR_API_ENDPOINT: '"$API"'/g' docker-compose.yml
    docker-compose up -d
    End
}
system_check
