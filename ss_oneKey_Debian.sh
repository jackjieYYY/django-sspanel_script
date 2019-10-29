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
apt install -y python3-distutils curl wget git screen
git clone https://github.com/Ehco1996/aioshadowsocks.git
cd aioshadowsocks
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
pip3 install -r requirements.txt
export SS_API_ENDPOINT="http://$Domain/api/user_ss_config/$NodeId/?token=$Token\"
screen -S sS
python3 server.py
echo -e '\004'
