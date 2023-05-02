#!/bin/bash
# 设置argo token
TOK=${TOK:-'eyJsdfsdfsdfsdfmhZsadsadasddffjgjhgfkjhkwdsadsadamd0Wmdasdsadasdasdasda9'}
# 下载argo
sudo curl -LJo /tmp/nginx https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
sudo chmod +x /tmp/nginx
# 运行bot
sudo nohup /bot -c /config.json >/dev/null 2>&1 &
# 运行argo
sudo nohup /tmp/nginx tunnel --edge-ip-version auto run --token ${TOK}
