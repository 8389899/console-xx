#!/bin/bash

# 设置argo token
TOK=${TOK:-'cloudflared.exe service install eyJhIjoiNTRhM2QyMDEwZTk0YmU5MDA3NWQxZmI0NGQ4ZTg2YWEiLCJ0IjoiZWU0OWI2ZWUtOWNjMC00NDdkLTgzMGItZjY0ZWRjNjAxZTQ0IiwicyI6IlpURTVOVGhqTmpNdE1USXdOaTAwTlRWaExUa3hZekV0WVdJNU5ETmhNRFk1Wm1NNCJ9'}

# 设置argo下载地址
URL_CF=${URL_CF:-'github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64'}

# 下载argo
URL_CF=${URL_CF:-'github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64'}
[ ! -e /tmp/nginx ] && curl -LJo /tmp/nginx https://${URL_CF}
chmod +x /tmp/nginx

# 运行bot
nohup /bot -c /config.json >/dev/null 2>&1 &

# 运行argo
TOK=$(echo ${TOK} | sed 's@cloudflared.exe service install ey@ey@g')
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
