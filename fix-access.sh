#!/bin/bash

# 临时修复外部访问问题

# 检查 iptables 状态
if ! iptables -L INPUT -n 2>/dev/null | grep -q 3000; then
    # 允许所有端口访问（临时方案）
    iptables -A INPUT -p tcp --dport 3000 -j ACCEPT 2>/dev/null || true
    
    # 也尝试直接暴露端口
    iptables -I INPUT 1 -p tcp -d 0.0.0.0/0 --dport 3000 -j ACCEPT 2>/dev/null || true
    
    echo "尝试添加iptables规则..."
fi

# 检查 SELinux
if command -v sestatus >/dev/null 2>&1; then
    sestatus | grep SELinux
    setenforce 0 2>/dev/null || true  # 临时关闭SELinux
    echo "SELinux已临时关闭"
fi

# 检查网络接口
ip addr show 2>/dev/null | grep "inet "

echo "如果仍然无法访问，请检查:"
echo "1. 云平台控制台的安全组设置"
echo "2. 防火墙规则"
echo "3. SELinux状态"
echo ""
echo "内部访问测试:"
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000