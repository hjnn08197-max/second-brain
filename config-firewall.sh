#!/bin/bash

# 配置防火墙允许外部访问3000和3001端口

echo "配置防火墙规则..."

# 清除之前的规则
iptables -F 2>/dev/null || true
iptables -X 2>/dev/null || true
iptables -t nat -F 2>/dev/null || true
iptables -t nat -X 2>/dev/null || true

# 设置默认策略
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# 允许本地回环
iptables -A INPUT -i lo -j ACCEPT

# 允许已建立的连接
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# 允许SSH端口22
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# 允许Next.js端口3000和3001
iptables -A INPUT -p tcp --dport 3000 -j ACCEPT
iptables -A INPUT -p tcp --dport 3001 -j ACCEPT

# 保存规则
iptables-save > /etc/iptables/rules.v4 2>/dev/null || true

echo "防火墙规则已配置:"
echo "- SSH端口: 22 ✓"
echo "- Next.js端口: 3000 ✓"
echo "- Next.js端口: 3001 ✓"

echo ""
echo "当前监听端口:"
ss -tlnp | grep -E ':(3000|3001)'

echo ""
echo "测试连接:"
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000
echo " - 端口3000"
curl -s -o /dev/null -w "%{http_code}" http://localhost:3001  
echo " - 端口3001"