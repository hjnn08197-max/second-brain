#!/bin/bash

cd /root/.openclaw/workspace/second-brain

echo "尝试在端口3001启动服务器..."

pkill -f "next-server"
sleep 3

export HOST=0.0.0.0
export PORT=3001
npm run dev &

sleep 5
echo "服务器已在端口3001启动"
netstat -tlnp | grep 3001