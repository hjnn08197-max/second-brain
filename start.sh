#!/bin/bash

cd /root/.openclaw/workspace/second-brain

# 停止之前的进程
pkill -f "next-server"
sleep 2

# 启动新进程
export HOST=0.0.0.0
export PORT=3000
npm run dev &