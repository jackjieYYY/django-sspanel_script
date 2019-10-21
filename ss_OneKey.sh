#!/bin/bash
Domain=nai-ve.com
Token=admin
APIinit(){
echo "请输入节点ID"
read NodeId
API="\"http:\/\/$Domain\/api\/user_ss_config\/$NodeId\/?token=$Token\""
}
APIinit
echo $API
yum install -y curl git
curl -sSL https://get.docker.com/ | sh
curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
git clone https://github.com/Ehco1996/aioshadowsocks.git
cd aioshadowsocks
systemctl restart docker
sed -i 's/SS_API_ENDPOINT: \"\"/SS_API_ENDPOINT: '"$API"'/g' docker-compose.yml
docker-compose up
