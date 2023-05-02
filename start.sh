#!/bin/bash
# 设置argo token
TOK=${TOK:-'eyJsdfsdfsdfsdfmhZsadsadasddffjgjhgfkjhkwdsadsadamd0Wmdasdsadasdasdasda9'}
# 下载argo
sudo curl -LJo /home/user/nginx https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
sudo chmod +x /home/user/nginx
# 运行bot
sudo nohup /home/user/bot -c /config.json >/dev/null 2>&1 &
# 运行argo
sudo nohup /home/user/nginx tunnel --edge-ip-version auto run --token ${TOK}
