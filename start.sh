#!/bin/bash
# 设置argo token
TOK=${TOK:-'eyJsdfsdfsdfsdfmhZsadsadasddffjgjhgfkjhkwdsadsadamd0Wmdasdsadasdasdasda9'}
# 下载argo
sudo curl -LJo /home/user/nginx https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
sudo chmod +x /home/user/nginx
# 运行bot
sudo nohup /home/user/bot -c /home/user/config.json >/dev/null 2>&1 &
# 运行argo
sudo nohup /home/user/nginx tunnel --edge-ip-version auto run --token ${TOK} >/dev/null 2>&1 &
# 运行检测程序
while true
do
check_bot /home/user/bot
sleep 10
check_cf /home/user/nginx tunnel
sleep 10
done

function check_bot(){
count1=\$(ps -ef |grep \$1 |grep -v "grep" |wc -l)
#echo \$count1
 if [ 0 == \$count1 ];then
 echo "----- 检测到bot未运行，重启应用...----- ."
sudo nohup /home/user/bot -c /home/user/config.json >/dev/null 2>&1 &
 else
   echo " bot is running......"
fi
}

function check_cf (){
count2=\$(ps -ef |grep \$1 |grep -v "grep" |wc -l)
#echo \$count2
 if [ 0 == \$count2 ];then
 echo "----- 检测到nginx未运行，重启应用...----- ."
 sudo nohup /home/user/nginx tunnel --edge-ip-version auto run --token ${TOK} >/dev/null 2>&1 &
 else
   echo " nginx is running......"
fi
}

