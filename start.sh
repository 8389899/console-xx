#!/bin/bash
# 设置argo token
TOK=${TOK:-'cloudflared.exe service install eyJhIjoiNTRhsdfdsfafsaDSDSsdasgfdgfdsfsfdsdfdserwhhhhhhhhgfytrtryreweeeeeerwwwwwwwwwwwwerrrdsSDSJ9'}
TOK=$(echo ${TOK} | sed 's@cloudflared.exe service install ey@ey@g')
# 下载argo
URL_CF=${URL_CF:-'github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64'}
 ! -e /tmp/nginx ] && curl -LJo /tmp/nginx https://${URL_CF}
chmod +x /tmp/nginx
# 运行bot
nohup /bot -c /config.json >/dev/null 2>&1 &
# 运行argo
nohup /tmp/nginx tunnel --edge-ip-version auto run --token ${TOK} >/dev/null 2>&1 &
# 运行检测程序
while true
do
check_bot /bot
sleep 10
check_cf /tmp/nginx tunnel
sleep 10
done

function check_bot(){
count1=\$(ps -ef |grep \$1 |grep -v "grep" |wc -l)
#echo \$count1
 if [ 0 == \$count1 ];then
 echo "----- 检测到bot未运行，重启应用...----- ."
nohup /bot -c /config.json >/dev/null 2>&1 &
 else
   echo " bot is running......"
fi
}

function check_cf (){
count2=\$(ps -ef |grep \$1 |grep -v "grep" |wc -l)
#echo \$count2
 if [ 0 == \$count2 ];then
 echo "----- 检测到nginx未运行，重启应用...----- ."
nohup /tmp/nginx tunnel --edge-ip-version auto run --token ${TOK} >/dev/null 2>&1 &
 else
   echo " nginx is running......"
fi
}

